import UIKit
import SwiftUI
import BDIdentityVerification

final class ViewController: UIViewController, BDIVDelegate {
    private var identityVerification: BecomeDigitalSDK?
    private let status = VerificationStatus()

    override func viewDidLoad() {
        super.viewDidLoad()
        let host = UIHostingController(
            rootView: VerificationScreen(status: status) { [weak self] userId in
                self?.startOnboarding(userId: userId)
            }
        )
        addChild(host)
        host.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(host.view)
        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            host.view.topAnchor.constraint(equalTo: view.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        host.didMove(toParent: self)
    }

    private func startOnboarding(userId: String) {
        guard !userId.isEmpty else {
            status.text = NSLocalizedString("user_id_required", comment: "Missing user ID")
            return
        }
        guard let url = Bundle.main.url(forResource: "DemoConfiguration", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let values = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any],
              let jwt = (values["jwt"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines),
              let resultsJwt = (values["verificationResultsJwt"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines),
              let contractId = (values["contractId"] as? String)?.trimmingCharacters(in: .whitespacesAndNewlines),
              !jwt.isEmpty, !resultsJwt.isEmpty, !contractId.isEmpty else {
            status.text = NSLocalizedString("credentials_missing", comment: "Missing local demo credentials")
            return
        }
        guard Bundle.main.url(forResource: "com.become.blinkid.key", withExtension: "txt") != nil else {
            status.text = NSLocalizedString("license_missing", comment: "Missing BlinkID license")
            return
        }
        var config = BDIVConfig(
            jwt: jwt,
            contractId: contractId,
            documenTypes: [.DNI, .PASSPORT],
            userId: userId,
            flow: .Onboarding,
            debugLogsEnabled: values["debugLogsEnabled"] as? Bool ?? false,
            themeMode: .system
        )
        config.verificationResultsJwt = resultsJwt
        identityVerification = BecomeDigitalSDK(bdivConfig: config, delegate: self)
        status.text = NSLocalizedString("status_starting", comment: "Starting verification")
        identityVerification?.startVerification()
    }

    func BDIVResponseSuccess(bdivResult: BDIdentityVerificationResponse) {
        DispatchQueue.main.async {
            self.status.text = String(
                format: NSLocalizedString("sdk_status", comment: "SDK response status"),
                String(describing: bdivResult.responseStatus)
            )
        }
    }

    func BDIVResponseError(error: String) {
        DispatchQueue.main.async {
            self.status.text = String(
                format: NSLocalizedString("sdk_error", comment: "SDK error message"), error
            )
        }
    }
}
