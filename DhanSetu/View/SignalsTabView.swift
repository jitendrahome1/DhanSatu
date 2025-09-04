import SwiftUI

struct SignalsTabView: View {
    @Binding var selectedMainTab: String
    @State private var selectedTradeTab: String = "All Trades"
    @State private var selectedFilter: String = "All"
    @State private var selectedEquityTab: String = "Equity"
    @State private var selectedActiveTab: String = "Active Trades"
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Section
            CustomNavHeader(
                userName: "Ayush",
                greeting: "Signals",
                onSearchTapped: {
                    print("Search tapped in Signals")
                },
                onNotificationTapped: {
                    print("Notification tapped in Signals")
                }
            )
            
            // Scrollable Content
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 16, pinnedViews: []) {
                    // Equity/F&O Tabs
                    EquityFOTabs(selectedTab: $selectedEquityTab)
                    
                    // Live Signals Section
                    LiveSignalsSection(
                        selectedTab: $selectedTradeTab,
                        selectedFilter: $selectedFilter
                    )
                    
                    // Enhanced Stock Signal Card
                    EnhancedStockSignalCard()
                    
                    // Active/Closed Trades Section
                    ActiveClosedTradesSection(selectedTab: $selectedActiveTab)
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
    SignalsTabView(selectedMainTab: .constant("Signals"))
}
