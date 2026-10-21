# Screen-capture protection — iOS

This guide applies to the XCFramework in this repository. `BDIVConfig.preventScreenCapture` defaults to `false` in Debug and Release. Earlier distributions defaulted to `true`.

| Value | SDK behavior |
| --- | --- |
| `false` (default) | The SDK does not apply its screenshot protection or recording-blocking overlay. |
| `true` | The SDK protects its screens and displays a blocking overlay while screen recording is detected. |

The option covers SDK screens; it does not configure the host's other screens or override protections applied independently by iOS or other components.

## Enable explicitly

```swift
let config = BDIVConfig(
    clienId: "YOUR_CLIENT_ID",
    clientSecret: "YOUR_CLIENT_SECRET",
    contractId: "YOUR_CONTRACT_ID",
    documenTypes: [.DNI, .PASSPORT],
    userId: "YOUR_USER_ID",
    preventScreenCapture: true
)
let verification = BecomeDigitalSDK(bdivConfig: config, delegate: self)
verification.startVerification()
```

Omit the parameter or pass `false` to allow capture. The value is fixed for a configuration instance; construct a new configuration to change it for a later flow. Both onboarding and authentication support the option.

## Upgrade

Review calls that previously omitted this parameter. Pass `true` where protection must remain enabled. Explicit `true` or `false` values retain their requested behavior. Rebuild the host app with the framework and dependencies in the [README](README.md).

On a physical device, verify screenshots and recording during document capture, facial verification, cancellation, and return to the host. Test both settings if the host supports both modes.
