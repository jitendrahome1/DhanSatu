import SwiftUI

struct HomeTabView: View {
    @Binding var selectedMainTab: String
    @State private var selectedTradeTab: String = "All Trades"
    @State private var selectedFilter: String = "All"
    @State private var selectedEquityTab: String = "Equity"
    @StateObject private var signalViewModel = StockSignalViewModel()
    @State private var showNotifications = false
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
                    showNotifications = true
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
                    
                    if signalViewModel.isLoading {
                        ProgressView()
                            .padding()
                    } else if let error = signalViewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    } else if !signalViewModel.stockSignals.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(signalViewModel.stockSignals) { signal in
                                    StockSignalCard(stockSignal: signal)
                                        .frame(width: 350)
                                        .transition(.opacity)
                                }
                            }
                            .animation(.easeInOut, value: signalViewModel.stockSignals)
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    } else {
                        Text("No signals available")
                            .padding()
                    }
                }
            } //.padding(.horizontal, 16)
            
            .onAppear {
                signalViewModel.fetchStockSignals()
            }

            MainBottomTabBar(selectedTab: $selectedMainTab)
        }
        .padding(.horizontal, 16)
        .background(
            NavigationLink(
                destination: NotificationListView(),
                isActive: $showNotifications,
                label: { EmptyView() }
            )
            .hidden()
        )
    }
}
