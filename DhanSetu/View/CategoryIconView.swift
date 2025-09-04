import SwiftUI

struct CategoryIconView: View {
    let iconName: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: iconName)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white)
            }
            .frame(width: 70)
        }
    }
}

struct CategoryIconsView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                CategoryIconView(iconName: "chart.pie.fill", title: "Sector") {
                    print("Sector tapped")
                }
                
                CategoryIconView(iconName: "flame.fill", title: "Heatmap") {
                    print("Heatmap tapped")
                }
                
                CategoryIconView(iconName: "newspaper.fill", title: "Live News") {
                    print("Live News tapped")
                }
                
                CategoryIconView(iconName: "list.bullet.clipboard", title: "Watchlist") {
                    print("Watchlist tapped")
                }
                
                CategoryIconView(iconName: "chart.bar.fill", title: "F&O") {
                    print("F&O tapped")
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        CategoryIconsView()
    }
}