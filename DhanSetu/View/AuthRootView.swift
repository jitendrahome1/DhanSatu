import SwiftUI

struct AuthRootView: View {
  @StateObject private var auth = AuthSession()
  @StateObject private var tabBarVisibility = TabBarVisibility()

  var body: some View {
    Group {
      if auth.isAuthenticated {
        MainTabView()
          .environmentObject(tabBarVisibility)
          .environmentObject(auth)
      } else {
        LoginView()
          .environmentObject(auth)
      }
    }
    .animation(.default, value: auth.isAuthenticated)
  }
}

#Preview {
  AuthRootView()
}