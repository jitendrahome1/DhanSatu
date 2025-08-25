import SwiftUI

struct OTPInputView: View {
    @Binding var otpCode: String
    var phoneNumber: String
    var countryCode: String
    @Binding var isVerifying: Bool
    var canVerify: Bool
    var verifyAction: () -> Void
    @Binding var resendSecondsRemaining: Int
    var resendAction: () -> Void
    var changePhoneAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                Text("Code sent to").font(.footnote).foregroundStyle(.secondary)
                HStack(spacing: 8) {
                    Text(maskedPhone(phoneNumber)).font(.subheadline.weight(.medium))
                    Button("Change") { changePhoneAction() }
                        .font(.footnote.weight(.semibold))
                }
            }

            OTPBoxesView(text: $otpCode)

            Button {
                verifyAction()
            } label: {
                HStack {
                    if isVerifying { ProgressView().tint(.white) }
                    Text(isVerifying ? "Verifying…" : "Verify").fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .disabled(!canVerify)

            HStack(spacing: 8) {
                if resendSecondsRemaining > 0 {
                    Text("Resend in \(resendSecondsRemaining)s")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } else {
                    Button("Resend OTP") { resendAction() }
                        .buttonStyle(.borderless)
                }
            }
            .padding(.top, 4)
        }
    }

    private func maskedPhone(_ input: String) -> String {
        let digits = input.filter { $0.isNumber }
        guard digits.count >= 4 else { return "\(countryCode) \(input)" }
        let last4 = digits.suffix(4)
        return "\(countryCode) \u{2022}\u{2022}\u{2022}\u{2022} \(String(last4))"
    }
}
