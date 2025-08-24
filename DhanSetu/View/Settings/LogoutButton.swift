import SwiftUI

struct LogoutButton: View {
    let onLogout: () -> Void
    
    var body: some View {
        Button(action: onLogout) {
            Text("Logout")
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
        }
    }
}
