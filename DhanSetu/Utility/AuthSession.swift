import SwiftUI

final class AuthSession: ObservableObject {
  @Published var isAuthenticated: Bool

  init(isAuthenticated: Bool = false) {
    self.isAuthenticated = isAuthenticated
  }

  func signIn() { isAuthenticated = true }
  func signOut() { isAuthenticated = false }
}