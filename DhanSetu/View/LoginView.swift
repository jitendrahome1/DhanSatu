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

  private var isValidPhone: Bool {
    let digits = phoneNumber.filter { $0.isNumber }
    return digits.count >= 10 && digits.count <= 13
  }

  private var canSendOTP: Bool { isValidPhone && !isSendingOTP }
  private var canVerify: Bool { otpCode.count == 6 && !isVerifying }

  var body: some View {
    VStack(spacing: 20) {
      Spacer(minLength: 24)

      VStack(spacing: 6) {
        Text("Sign in")
          .font(.system(size: 28, weight: .bold))
        Text(stage == .phone ? "Enter your mobile number" : "Enter the 6-digit code")
          .foregroundStyle(.secondary)
      }

      Group {
        if stage == .phone {
          phoneEntry
        } else {
          otpEntry
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
    .onDisappear { stopResendTimer() }
  }

  private var phoneEntry: some View {
    VStack(spacing: 16) {
      HStack(spacing: 10) {
        Image(systemName: "phone.fill").foregroundStyle(.green)
        TextField("Mobile number", text: $phoneNumber)
          .keyboardType(.numberPad)
          .textContentType(.telephoneNumber)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.never)
      }
      .padding(14)
      .background(RoundedRectangle(cornerRadius: 12).strokeBorder(.quaternary))

      Button {
        sendOTP()
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
      .disabled(!canSendOTP)
    }
  }

  private var otpEntry: some View {
    VStack(spacing: 16) {
      VStack(spacing: 4) {
        Text("Code sent to")
          .font(.footnote)
          .foregroundStyle(.secondary)
        HStack(spacing: 8) {
          Text(maskedPhone(phoneNumber))
            .font(.subheadline.weight(.medium))
          Button("Change") {
            stopResendTimer()
            otpCode = ""
            errorMessage = nil
            infoMessage = nil
            stage = .phone
          }
          .font(.footnote.weight(.semibold))
        }
      }

      OTPBoxesView(text: $otpCode)

      Button {
        verifyOTP()
      } label: {
        HStack {
          if isVerifying { ProgressView().tint(.white) }
          Text(isVerifying ? "Verifying…" : "Verify")
            .fontWeight(.semibold)
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
          Button("Resend OTP") { resendOTP() }
            .buttonStyle(.borderless)
        }
      }
      .padding(.top, 4)
    }
  }

  private func sendOTP() {
    guard canSendOTP else { return }
    errorMessage = nil
    infoMessage = nil
    isSendingOTP = true

    // Simulate API call to send OTP
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
      isSendingOTP = false
      generatedOTP = String((0..<6).map { _ in String(Int.random(in: 0...9)) }.joined())
      stage = .otp
      startResendTimer()
      // Uncomment for debugging:
      // infoMessage = "Debug OTP: \(generatedOTP)"
    }
  }

  private func verifyOTP() {
    guard canVerify else { return }
    errorMessage = nil
    isVerifying = true

    // Simulate verification
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

  private func maskedPhone(_ input: String) -> String {
    let digits = input.filter { $0.isNumber }
    guard digits.count >= 4 else { return input }
    let last4 = digits.suffix(4)
    return "+** \u{2022}\u{2022}\u{2022}\u{2022} \(String(last4))"
  }
}

// MARK: - OTP Boxes Input

fileprivate struct OTPBoxesView: View {
  @Binding var text: String
  @FocusState private var isFocused: Bool

  private let length: Int = 6

  var body: some View {
    ZStack {
      HStack(spacing: 10) {
        ForEach(0..<length, id: \.self) { index in
          ZStack {
            RoundedRectangle(cornerRadius: 10)
              .strokeBorder(.quaternary)
              .background(
                RoundedRectangle(cornerRadius: 10)
                  .fill(Color(.secondarySystemBackground))
              )
              .frame(height: 54)

            Text(character(at: index))
              .font(.title2.weight(.semibold))
              .monospacedDigit()
          }
        }
      }

      TextField("", text: Binding(
        get: { String(text.prefix(length)).filter { $0.isNumber } },
        set: { new in
          let filtered = new.filter { $0.isNumber }
          text = String(filtered.prefix(length))
        }
      ))
      .keyboardType(.numberPad)
      .textContentType(.oneTimeCode)
      .focused($isFocused)
      .textInputAutocapitalization(.never)
      .disableAutocorrection(true)
      .tint(.clear)
      .foregroundStyle(.clear)
      .frame(width: 0, height: 0)
      .onAppear { DispatchQueue.main.async { isFocused = true } }
    }
    .contentShape(Rectangle())
    .onTapGesture { isFocused = true }
  }

  private func character(at index: Int) -> String {
    let chars = Array(text)
    if index < chars.count { return String(chars[index]) }
    return "\u{00A0}"
  }
}
