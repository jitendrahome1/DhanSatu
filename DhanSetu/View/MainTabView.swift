import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: String = "Home"
    
    var body: some View {
        NavigationView {
            ZStack {
                // Content based on selected tab
                Group {
                    switch selectedTab {
                    case "Home":
                        HomeTabView(selectedMainTab: $selectedTab)
                    case "Signals":
                        SignalsTabView(selectedMainTab: $selectedTab)
                    case "Portfolio":
                        PortfolioTabView(selectedMainTab: $selectedTab)
                    case "Markets":
                        MarketsTabView(selectedMainTab: $selectedTab)
                    case "Stryke":
                        StrykeTabView(selectedMainTab: $selectedTab)
                    default:
                        HomeTabView(selectedMainTab: $selectedTab)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .animation(.easeInOut(duration: 0.2), value: selectedTab)
    }
}

#Preview {
    MainTabView()
}
