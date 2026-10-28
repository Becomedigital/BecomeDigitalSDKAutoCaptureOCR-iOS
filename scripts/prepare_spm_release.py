#!/usr/bin/env python3
"""Validate and package the checked-in XCFramework for a SwiftPM release."""

from __future__ import annotations

import argparse
import hashlib
from pathlib import Path
import plistlib
import re
import shutil
import stat
import subprocess
import sys
import zipfile


ROOT = Path(__file__).resolve().parents[1]
FRAMEWORK = ROOT / "BDIdentityVerification.xcframework"
MANIFEST = ROOT / "Package.swift"
CHECKSUMS = ROOT / "CHECKSUMS.sha256"
RELEASE_BASE = "https://github.com/Becomedigital/BecomeDigitalSDKAutoCaptureOCR-iOS/releases/download"
ZIP_DATE = (1980, 1, 1, 0, 0, 0)


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def verify_existing_checksums() -> None:
    checked_paths: set[Path] = set()
    for line in CHECKSUMS.read_text(encoding="utf-8").splitlines():
        if not line.strip() or line.startswith("#"):
            continue
        expected, relative = line.split("  ", 1)
        path = (ROOT / relative).resolve()
        if not path.is_relative_to(FRAMEWORK) or not path.is_file() or path in checked_paths:
            raise ValueError(f"Missing or unsafe checksum path: {relative}")
        checked_paths.add(path)
        if sha256(path) != expected:
            raise ValueError(f"XCFramework content differs from CHECKSUMS.sha256: {relative}")
    framework_paths = {path.resolve() for path in FRAMEWORK.rglob("*") if path.is_file()}
    if checked_paths != framework_paths:
        raise ValueError("CHECKSUMS.sha256 does not cover every XCFramework file")


def inspect_framework(release_version: str, require_privacy_manifest: bool) -> None:
    with (FRAMEWORK / "Info.plist").open("rb") as stream:
        info = plistlib.load(stream)
    libraries = info.get("AvailableLibraries", [])
    if len(libraries) != 2:
        raise ValueError("Expected one iOS device slice and one iOS Simulator slice")

    expected_slices = {
        ("ios", None): {"arm64"},
        ("ios", "simulator"): {"arm64", "x86_64"},
    }
    seen: set[tuple[str, str | None]] = set()
    for library in libraries:
        key = (library.get("SupportedPlatform"), library.get("SupportedPlatformVariant"))
        if key not in expected_slices or key in seen:
            raise ValueError(f"Unexpected or duplicate XCFramework slice: {key}")
        seen.add(key)
        if set(library.get("SupportedArchitectures", [])) != expected_slices[key]:
            raise ValueError(f"Unexpected architectures for {key}")

        bundle = FRAMEWORK / library["LibraryIdentifier"] / library["LibraryPath"]
        with (bundle / "Info.plist").open("rb") as stream:
            bundle_info = plistlib.load(stream)
        expected_bundle_version = release_version.split("-", 1)[0]
        if bundle_info.get("CFBundleShortVersionString") != expected_bundle_version:
            raise ValueError(f"Framework version differs from {release_version}: {bundle}")
        if bundle_info.get("MinimumOSVersion") != "16.0":
            raise ValueError(f"Expected minimum iOS 16.0 in {bundle}")
        if bundle_info.get("BaseUrl") != "https://api.svi.becomedigital.net":
            raise ValueError(f"Non-production API URL in {bundle}")

        required = (
            "BDIdentityVerification",
            "Assets.car",
            "Model.momd/Model.mom",
            "AmplifyUILiveness_FaceLiveness.bundle/face_detection_short_range.mlmodelc/model.espresso.weights",
            "amplifyconfiguration.json",
            "Fonts/Inter.ttf",
            "es.lproj/Dictionary.stringsdict",
            "en.lproj/Dictionary.stringsdict",
        )
        for relative in required:
            if not (bundle / relative).is_file():
                raise ValueError(f"Required resource is missing: {bundle / relative}")
        if not list((bundle / "Modules" / "BDIdentityVerification.swiftmodule").glob("*.swiftinterface")):
            raise ValueError(f"Swift module interface is missing: {bundle}")
        privacy_manifest = bundle / "PrivacyInfo.xcprivacy"
        if not privacy_manifest.is_file():
            message = f"PrivacyInfo.xcprivacy is missing from {bundle}"
            if require_privacy_manifest:
                raise ValueError(message)
            print(f"WARNING: {message}", file=sys.stderr)

    if seen != set(expected_slices):
        raise ValueError("The XCFramework is missing a required platform slice")
    verify_existing_checksums()


def make_zip(version: str) -> Path:
    output = ROOT / "dist" / f"BDIdentityVerification-{version}.xcframework.zip"
    output.parent.mkdir(exist_ok=True)
    temporary = output.with_suffix(".zip.tmp")
    try:
        with zipfile.ZipFile(temporary, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
            for path in sorted(FRAMEWORK.rglob("*")):
                if path.is_symlink():
                    raise ValueError(f"Symlinks require an explicit packaging policy: {path}")
                if not path.is_file():
                    continue
                relative = path.relative_to(ROOT).as_posix()
                entry = zipfile.ZipInfo(relative, date_time=ZIP_DATE)
                entry.create_system = 3
                entry.compress_type = zipfile.ZIP_DEFLATED
                mode = stat.S_IMODE(path.stat().st_mode)
                entry.external_attr = (stat.S_IFREG | mode) << 16
                with path.open("rb") as source, archive.open(entry, "w", force_zip64=True) as target:
                    shutil.copyfileobj(source, target, length=1024 * 1024)
        temporary.replace(output)
    finally:
        temporary.unlink(missing_ok=True)
    return output


def replace_once(text: str, pattern: str, replacement: str) -> str:
    result, count = re.subn(pattern, replacement, text, flags=re.MULTILINE)
    if count != 1:
        raise ValueError(f"Expected one Package.swift declaration for {pattern}")
    return result


def verify_or_update_manifest(version: str, checksum: str, check_only: bool) -> None:
    current = MANIFEST.read_text(encoding="utf-8")
    updated = replace_once(
        current,
        r'^let artifactVersion = "[^"]+"$',
        f'let artifactVersion = "{version}"',
    )
    updated = replace_once(
        updated,
        r'^let artifactChecksum = "[^"]+"$',
        f'let artifactChecksum = "{checksum}"',
    )
    if check_only:
        if current != updated:
            raise ValueError("Package.swift does not match the XCFramework ZIP; regenerate it")
    else:
        MANIFEST.write_text(updated, encoding="utf-8")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--version", required=True, help="SemVer release tag, for example 1.2.3 or 1.2.4-rc.1")
    parser.add_argument("--check", action="store_true", help="Verify Package.swift without changing it")
    parser.add_argument("--require-privacy-manifest", action="store_true", help="Fail when the XCFramework lacks a privacy manifest")
    args = parser.parse_args()
    if not re.fullmatch(r"[0-9]+\.[0-9]+\.[0-9]+(?:-(?:rc|beta)\.[0-9]+)?", args.version):
        parser.error("--version must be a SemVer release or RC version")

    inspect_framework(args.version, args.require_privacy_manifest)
    zip_path = make_zip(args.version)
    checksum = subprocess.run(
        ["swift", "package", "compute-checksum", str(zip_path)],
        check=True,
        text=True,
        capture_output=True,
    ).stdout.strip()
    if checksum != sha256(zip_path):
        raise ValueError("SwiftPM checksum differs from the ZIP SHA-256")
    verify_or_update_manifest(args.version, checksum, args.check)

    print(f"Artifact: {zip_path}")
    print(f"SwiftPM checksum: {checksum}")
    print(f"Release URL: {RELEASE_BASE}/{args.version}/{zip_path.name}")


if __name__ == "__main__":
    try:
        main()
    except (OSError, KeyError, ValueError, subprocess.CalledProcessError, zipfile.BadZipFile) as error:
        print(f"SPM preparation failed: {error}", file=sys.stderr)
        sys.exit(1)
