# Swift Package Manager distribution

This repository distributes the `BDIdentityVerification` module as a binary Swift package. The source repositories remain separate. The package product carries the BlinkIDUX, Amplify, and FaceLiveness products used by the existing Xcode integration.

## Consumer installation

After the matching GitHub Release is published, add this package URL in Xcode:

```text
https://github.com/Becomedigital/BecomeDigitalSDKAutoCaptureOCR-iOS.git
```

Select the `BDIdentityVerification` library product and an **Exact Version**, such as `1.2.3`. Swift code continues to use `import BDIdentityVerification`. Keep the app's `Package.resolved` in version control. The application supplies its own BlinkID license file (`com.become.blinkid.key.txt`) for its bundle identifier, camera usage description, and any optional location permission. The host application embeds and signs the dynamic frameworks.

Remove manually linked copies of `BDIdentityVerification.xcframework`, BlinkID, BlinkIDUX, Amplify, and FaceLiveness when switching an existing app to the package product. Check the final application for one copy of each dynamic framework.

## Artifact and version contract

- The package tag, GitHub Release tag, and artifact filename use the same semantic version. For example, tag `1.2.3` contains `BDIdentityVerification-1.2.3.xcframework.zip`.
- `Package.swift` references that Release asset and its `swift package compute-checksum` value. The ZIP contains `BDIdentityVerification.xcframework` at its root.
- The framework's `CFBundleShortVersionString` must match the numeric part of the package version. Release candidates may append `-rc.N` to the tag while retaining the matching numeric framework version.
- Published tags and Release assets must remain immutable. A changed binary requires a new version and checksum.
- The checked-in XCFramework is the source of the ZIP. The generated `dist/` directory is local output and is excluded from Git.

Prepare an artifact on macOS after updating the checked-in XCFramework and `CHECKSUMS.sha256`:

```sh
python3 scripts/prepare_spm_release.py --version 1.2.3
python3 scripts/prepare_spm_release.py --version 1.2.3 --check
```

The preparation command validates device and Simulator slices, iOS 16.0 minimum deployment, production API URL, framework version, required resources, and the existing file checksums. It builds a deterministic ZIP and updates the manifest checksum. Re-running the command on unchanged inputs yields the same checksum. The command prints the exact Release asset URL to use.

## Release gate

Before uploading an asset, run the stricter check:

```sh
python3 scripts/prepare_spm_release.py --version 1.2.3 --check --require-privacy-manifest
```

The current XCFramework lacks `PrivacyInfo.xcprivacy` in both slices. The iOS source project has a privacy manifest reference, but the built artifact needs a reviewed manifest bundled in each framework slice. Regenerate the XCFramework from the production source build after that correction, refresh `CHECKSUMS.sha256`, and rerun the preparation command. The source privacy declarations also need product and legal review before publication.

The current framework is not vendor-signed. The consuming app signs it during embedding. If BecomeDigital chooses to sign the distributed XCFramework, sign the final artifact **before** producing the ZIP and checksum, and validate the signature in the release pipeline. This requires access to the selected Apple signing identity in the publishing environment.

The GitHub Release asset does not exist yet. This phase prepares its URL and checksum; release automation and public download verification belong to the release phase.
