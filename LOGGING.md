# Diagnostic logging — iOS

Enable logs when constructing the configuration for an investigation:

```swift
let config = BDIVConfig(
    clienId: clientId,
    clientSecret: clientSecret,
    contractId: contractId,
    documenTypes: [.DNI, .PASSPORT],
    userId: userId,
    debugLogsEnabled: true
)
verification = BecomeDigitalSDK(bdivConfig: config, delegate: self)
verification?.startVerification()
```

The default is `false`; disable logging when the investigation ends. In Xcode or Console, include **Debug** messages and filter for `BecomeSDK`.

For support, include the SDK version, device, visible step, and relevant `BecomeSDK` lines. Review logs before sharing and exclude credentials, license contents, images, and personal data.
