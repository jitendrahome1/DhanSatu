import SwiftUI

struct TopBarView: View {
    var body: some View {
        HStack {
            // Navigate to SettingsView when tapped
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "person.crop.circle.fill") // Avatar
                    .font(.system(size: 28))
                    .foregroundColor(.blue)
            }

            TextField("Search for \"TATA\"", text: .constant(""))
                .padding(10)
                .background(Color(.systemGray5))
                .cornerRadius(10)

            Image(systemName: "bell.fill")
                .foregroundColor(.green)
        }
        .padding(.horizontal)
    }
}
