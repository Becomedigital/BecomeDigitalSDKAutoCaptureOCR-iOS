import SwiftUI

final class VerificationStatus: ObservableObject {
    @Published var text = NSLocalizedString("status_ready", comment: "Initial verification status")
}

struct VerificationScreen: View {
    @ObservedObject var status: VerificationStatus
    let onStart: (String) -> Void
    @State private var userId = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("host_title")
                .font(.title2)
            TextField("user_id_label", text: $userId)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            Button("start_onboarding") {
                onStart(userId.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            Text(status.text)
            Spacer()
        }
        .padding(24)
    }
}
