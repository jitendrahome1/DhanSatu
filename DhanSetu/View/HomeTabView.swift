import SwiftUI

struct HomeTabView: View {
    @Binding var selectedMainTab: String
    @State private var selectedTradeTab: String = "All Trades"
    @State private var selectedFilter: String = "All"
    @State private var selectedEquityTab: String = "Equity"
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Section
            CustomNavHeader(
                userName: "Ayush",
                greeting: "Hello",
                onSearchTapped: {
                    print("Search tapped in Home")
                },
                onNotificationTapped: {
                    print("Notification tapped in Home")
                }
            )
            
            // Scrollable Content
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16, pinnedViews: []) {
                    // Margin Available Card
                    DhanMarginHeaderView()
                    
                    // Feature Icons Grid
                    FeatureIconsGrid()
                    
                    // AI-Powered Signals Card
                    AIPoweredSignalsCard()
                    
                    // Equity/F&O Tabs
                    EquityFOTabs(selectedTab: $selectedEquityTab)
                    
                    // Live Signals Section
                    LiveSignalsSection(
                        selectedTab: $selectedTradeTab,
                        selectedFilter: $selectedFilter
                    )
                    
                    // Stock Signal Card
                    StockSignalCard()
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 100) // Space for bottom tab bar
            }
            .background(Color(.systemGroupedBackground))
            
            // Bottom Tab Bar - Fixed at bottom
            MainBottomTabBar(selectedTab: $selectedMainTab)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarHidden(true)
    }
}

#Preview {
    HomeTabView(selectedMainTab: .constant("Home"))
}
