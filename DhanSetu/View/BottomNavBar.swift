import SwiftUI
struct BottomNavBar: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "house.fill")
            Spacer()
            Image(systemName: "indianrupee.circle.fill")
            Spacer()
            Image(systemName: "bolt.fill") // For SW logo
            Spacer()
            Image(systemName: "chart.bar.fill")
            Spacer()
            Image(systemName: "magnifyingglass.circle.fill")
            Spacer()
        }
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
    }
}
