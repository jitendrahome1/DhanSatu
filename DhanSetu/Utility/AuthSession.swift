import SwiftUI

final class AuthSession: ObservableObject {
  @Published var isAuthenticated: Bool {
    didSet { save() }
  }

  init(isAuthenticated: Bool = UserDefaults.standard.bool(forKey: AppConstants.authLoggedInKey)) {
    self.isAuthenticated = isAuthenticated
  }

  func signIn() {
    isAuthenticated = true
  }

  func signOut() {
    isAuthenticated = false
  }

  private func save() {
    UserDefaults.standard.set(isAuthenticated, forKey: AppConstants.authLoggedInKey)
  }
}