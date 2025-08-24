import SwiftUI

struct LoginView: View {
  @Binding var isAuthenticated: Bool

  @State private var email: String = ""
  @State private var password: String = ""
  @State private var showPassword: Bool = false
  @State private var isLoading: Bool = false
  @State private var errorMessage: String?

  private var isValidEmail: Bool {
    email.contains("@") && email.contains(".")
  }
  private var isValidPassword: Bool {
    password.count >= 6
  }
  private var canLogin: Bool {
    isValidEmail && isValidPassword && !isLoading
  }

  var body: some View {
    VStack(spacing: 18) {
      Spacer(minLength: 24)

      VStack(spacing: 6) {
        Text("Welcome back")
          .font(.system(size: 28, weight: .bold))
        Text("Sign in to continue")
          .foregroundStyle(.secondary)
      }

      VStack(spacing: 12) {
        HStack(spacing: 10) {
          Image(systemName: "envelope.fill").foregroundStyle(.green)
          TextField("Email", text: $email)
            .textContentType(.emailAddress)
            .keyboardType(.emailAddress)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 12).strokeBorder(.quaternary))

        HStack(spacing: 10) {
          Image(systemName: "lock.fill").foregroundStyle(.green)
          Group {
            if showPassword {
              TextField("Password (min 6)", text: $password)
            } else {
              SecureField("Password (min 6)", text: $password)
            }
          }
          Button {
            showPassword.toggle()
          } label: {
            Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
              .foregroundStyle(.secondary)
          }
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 12).strokeBorder(.quaternary))
      }

      if let error = errorMessage {
        Text(error)
          .font(.footnote)
          .foregroundStyle(.red)
      }

      Button {
        login()
      } label: {
        HStack {
          if isLoading { ProgressView().tint(.white) }
          Text(isLoading ? "Signing in…" : "Log in")
            .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .tint(.green)
      .disabled(!canLogin)

      HStack {
        Rectangle().fill(.quaternary).frame(height: 1)
        Text("or").foregroundStyle(.secondary).font(.caption)
        Rectangle().fill(.quaternary).frame(height: 1)
      }.padding(.vertical, 4)

      VStack(spacing: 10) {
        Button {
          // Hook up Sign in with Apple here
        } label: {
          Label("Continue with Apple", systemImage: "apple.logo")
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)

        Button {
          // Hook up Google sign-in here
        } label: {
          Label("Continue with Google", systemImage: "g.circle.fill")
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
      }

      HStack(spacing: 4) {
        Text("Don't have an account?")
        Button("Create one") { /* navigate to sign-up */ }
      }
      .font(.footnote)
      .padding(.top, 4)

      Spacer()
    }
    .padding(.horizontal, 20)
    .onSubmit(login)
  }

  private func login() {
    guard canLogin else { return }
    errorMessage = nil
    isLoading = true

    // Simulate API call; replace with real auth
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      isLoading = false
      if isValidEmail && isValidPassword {
        isAuthenticated = true
      } else {
        errorMessage = "Invalid credentials. Try again."
      }
    }
  }
}

#Preview {
  @Previewable @State var isAuthenticated = false
  return LoginView(isAuthenticated: $isAuthenticated)
}