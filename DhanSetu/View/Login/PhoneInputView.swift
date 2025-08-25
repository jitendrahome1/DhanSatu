import SwiftUI

struct PhoneInputView: View {
    @Binding var phoneNumber: String
    @Binding var countryCode: String
    @Binding var isSendingOTP: Bool
    var sendOTPAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 10) {
                Image(systemName: "phone.fill")
                    .foregroundStyle(.green)

                Menu {
                    Button("+91 India") { countryCode = "+91" }
                    Button("+1 USA") { countryCode = "+1" }
                    Button("+44 UK") { countryCode = "+44" }
                    Button("+971 UAE") { countryCode = "+971" }
                } label: {
                    HStack(spacing: 4) {
                        Text(countryCode)
                            .font(.subheadline.weight(.semibold))
                        Image(systemName: "chevron.down")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                .menuIndicator(.hidden)

                TextField("Mobile number", text: $phoneNumber)
                    .keyboardType(.numberPad)
                    .textContentType(.telephoneNumber)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .onChange(of: phoneNumber) { newValue in
                        phoneNumber = String(newValue.filter { $0.isNumber }.prefix(10))
                    }
            }
            .padding(14)
            .background(RoundedRectangle(cornerRadius: 12).strokeBorder(.quaternary))

            if phoneNumber.count < 10 {
                Text("Enter 10-digit number")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Button {
                sendOTPAction()
            } label: {
                HStack {
                    if isSendingOTP { ProgressView().tint(.white) }
                    Text(isSendingOTP ? "Sending…" : "Continue")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .disabled(phoneNumber.count != 10 || isSendingOTP)
        }
    }
}
