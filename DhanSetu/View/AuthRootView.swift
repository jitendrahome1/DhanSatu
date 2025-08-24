import SwiftUI

struct AuthRootView: View {
  @State private var isAuthenticated: Bool = false
  @StateObject private var tabBarVisibility = TabBarVisibility()

  var body: some View {
    Group {
      if isAuthenticated {
        MainTabView()
          .environmentObject(tabBarVisibility)
      } else {
        LoginView(isAuthenticated: $isAuthenticated)
      }
    }
    .animation(.default, value: isAuthenticated)
  }
}

#Preview {
  AuthRootView()
}