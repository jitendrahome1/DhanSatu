import SwiftUI

struct BottomTabBar: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "house.fill")
                .foregroundColor(.green)
            Spacer()
            Image(systemName: "indianrupee")
            Spacer()
            Image(systemName: "circle.fill")
                .foregroundColor(.green)
            Spacer()
            Image(systemName: "chart.bar.fill")
            Spacer()
            Image(systemName: "magnifyingglass")
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.8))
    }
}
