# Error handling — iOS

## Public callbacks

| Callback | Recommended handling |
| --- | --- |
| `BDIVResponseSuccess(bdivResult:)` with `.SUCCES` | Read the optional result for the flow. For authentication, also evaluate `authentication.result`. |
| `BDIVResponseError(error:)` | Restore the host UI and offer a user-initiated restart. This callback also handles cancellation. |

`SUCCES` retains its existing spelling for compatibility. The error/message string is descriptive text, not a stable error code. The typed `onboarding`, `verification`, and `authentication` objects are optional. With `performVerificationCheck=false`, `onboarding` acknowledges creation and does not establish final approval.

The SDK presents supported capture retries within its own UI. The host does not receive a callback for every unsuccessful camera attempt.

## Issues the host can address

- **Incomplete configuration:** check `clienId`, `clientSecret`, `contractId`, `userId`, and the document types required for onboarding.
- **Camera unavailable or denied:** check the device and the camera permission and `NSCameraUsageDescription`.
- **Capture license:** check `com.become.blinkid.key.txt`, its app target membership, and the licensed Bundle Identifier.
- **Connection interrupted:** let the user start a new attempt when connectivity returns.
- **Capture not completed:** let the user retry inside the SDK.
- **Verification session expired or invalid:** close the current flow and let the user start a new verification.

Do not compare localized error/message strings to decide approval or automatic retries. If an issue persists, share the SDK version, device, visible step, and relevant [diagnostic logs](LOGGING.md) with support. Exclude credentials, license contents, captured documents, and other personal data.
