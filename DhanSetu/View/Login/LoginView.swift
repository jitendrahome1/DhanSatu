import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthSession

    private enum LoginStage {
        case phone
        case otp
    }

    @State private var stage: LoginStage = .phone
    @State private var phoneNumber: String = ""
    @State private var otpCode: String = ""
    @State private var isSendingOTP: Bool = false
    @State private var isVerifying: Bool = false
    @State private var errorMessage: String?
    @State private var infoMessage: String?

    @State private var generatedOTP: String = ""
    @State private var resendSecondsRemaining: Int = 0
    @State private var resendTimer: Timer?
    @State private var countryCode: String = "+91"

    private var canSendOTP: Bool { phoneNumber.filter { $0.isNumber }.count == 10 && !isSendingOTP }
    private var canVerify: Bool { otpCode.count == 6 && !isVerifying }

    var body: some View {
        ZStack {
            // Professional Gradient Background
            LinearGradient(
                colors: [
                    Color(red: 0.0, green: 0.35, blue: 0.65), // deep blue
                    Color(red: 0.0, green: 0.55, blue: 0.85), // lighter blue
                    Color.white.opacity(0.95)                 // soft white overlay
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer(minLength: 24)

                // Logo / Splash
                Image("splashScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .accessibilityHidden(true)

                VStack(spacing: 6) {
                    Text("Sign in")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                    Text(stage == .phone ? "Enter your mobile number" : "Enter the 6-digit code")
                        .foregroundColor(Color.white.opacity(0.8))
                }

                Group {
                    if stage == .phone {
                        PhoneInputView(
                            phoneNumber: $phoneNumber,
                            countryCode: $countryCode,
                            isSendingOTP: $isSendingOTP,
                            sendOTPAction: sendOTP
                        )
                    } else {
                        OTPInputView(
                            otpCode: $otpCode,
                            phoneNumber: phoneNumber,
                            countryCode: countryCode,
                            isVerifying: $isVerifying,
                            canVerify: canVerify,
                            verifyAction: verifyOTP,
                            resendSecondsRemaining: $resendSecondsRemaining,
                            resendAction: resendOTP,
                            changePhoneAction: {
                                stopResendTimer()
                                otpCode = ""
                                errorMessage = nil
                                infoMessage = nil
                                stage = .phone
                            }
                        )
                    }
                }

                if let error = errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }

                if let info = infoMessage {
                    Text(info)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .onDisappear { stopResendTimer() }
    }

    // MARK: - OTP & Phone Handling

    private func sendOTP() {
        guard canSendOTP else { return }
        errorMessage = nil
        infoMessage = nil
        isSendingOTP = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            isSendingOTP = false
            generatedOTP = String((0..<6).map { _ in String(Int.random(in: 0...9)) }.joined())
            stage = .otp
            startResendTimer()
        }
    }

    private func verifyOTP() {
        guard canVerify else { return }
        errorMessage = nil
        isVerifying = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            isVerifying = false
            let isCorrect = otpCode == generatedOTP || otpCode == "123456"
            if isCorrect {
                stopResendTimer()
                auth.signIn()
            } else {
                errorMessage = "Incorrect code. Try again."
            }
        }
    }

    private func resendOTP() {
        guard resendSecondsRemaining == 0 else { return }
        otpCode = ""
        sendOTP()
    }

    private func startResendTimer() {
        stopResendTimer()
        resendSecondsRemaining = 30
        resendTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if resendSecondsRemaining > 0 {
                resendSecondsRemaining -= 1
            } else {
                timer.invalidate()
            }
        }
    }

    private func stopResendTimer() {
        resendTimer?.invalidate()
        resendTimer = nil
    }
}
