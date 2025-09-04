import SwiftUI

struct MainBottomTabBar: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack {
            TabBarItem(
                icon: selectedTab == "Home" ? "house.fill" : "house", 
                title: "Home", 
                isSelected: selectedTab == "Home"
            ) {
                selectedTab = "Home"
            }
            
            TabBarItem(
                icon: "flame.fill", 
                title: "Signals", 
                isSelected: selectedTab == "Signals"
            ) {
                selectedTab = "Signals"
            }
            
            TabBarItem(
                icon: "plus.square", 
                title: "Portfolio", 
                isSelected: selectedTab == "Portfolio"
            ) {
                selectedTab = "Portfolio"
            }
            
            TabBarItem(
                icon: "chart.bar", 
                title: "Markets", 
                isSelected: selectedTab == "Markets"
            ) {
                selectedTab = "Markets"
            }
            
            TabBarItem(
                icon: "xmark", 
                title: "Stryke", 
                isSelected: selectedTab == "Stryke"
            ) {
                selectedTab = "Stryke"
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(Color(.systemGray4))
                .frame(height: 1),
            alignment: .top
        )
    }
}

// MARK: - Tab Bar Item
struct TabBarItem: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(isSelected ? .green : .gray)
                
                Text(title)
                    .font(.caption2)
                    .foregroundColor(isSelected ? .green : .gray)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    VStack {
        Spacer()
        MainBottomTabBar(selectedTab: .constant("Home"))
    }
    .background(Color(.systemGroupedBackground))
}
