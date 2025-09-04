import SwiftUI

// MARK: - Portfolio Tab View
struct PortfolioTabView: View {
    @Binding var selectedMainTab: String
    
    var body: some View {
        VStack {
            CustomNavHeader(
                userName: "Ayush",
                greeting: "Portfolio"
            )
            
            Spacer()
            
            Text("Portfolio View")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text("Coming Soon...")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            MainBottomTabBar(selectedTab: $selectedMainTab)
        }
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Markets Tab View
struct MarketsTabView: View {
    @Binding var selectedMainTab: String
    
    var body: some View {
        VStack {
            CustomNavHeader(
                userName: "Ayush",
                greeting: "Markets"
            )
            
            Spacer()
            
            Text("Markets View")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text("Coming Soon...")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            MainBottomTabBar(selectedTab: $selectedMainTab)
        }
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Stryke Tab View
struct StrykeTabView: View {
    @Binding var selectedMainTab: String
    
    var body: some View {
        VStack {
            CustomNavHeader(
                userName: "Ayush",
                greeting: "Stryke"
            )
            
            Spacer()
            
            Text("Stryke View")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text("Coming Soon...")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            MainBottomTabBar(selectedTab: $selectedMainTab)
        }
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    VStack {
        PortfolioTabView(selectedMainTab: .constant("Portfolio"))
        
        Divider()
        
        MarketsTabView(selectedMainTab: .constant("Markets"))
        
        Divider()
        
        StrykeTabView(selectedMainTab: .constant("Stryke"))
    }
}
