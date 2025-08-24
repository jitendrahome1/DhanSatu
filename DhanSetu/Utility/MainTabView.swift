import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem
    @EnvironmentObject var tabBarVisibility: TabBarVisibility

    let tabs: [TabItem] = [
        TabItem(title: "Home", icon: "house.fill", view: AnyView(MainStockScreenView())),
        TabItem(title: "Signals", icon: "indianrupee", view: AnyView(Text("Signals View").foregroundColor(.white))),
        TabItem(title: "SW", icon: "magnifyingglass", view: AnyView(PortfolioScreen())),
        TabItem(title: "Markets", icon: "chart.bar.fill", view: AnyView(Text("Markets View").foregroundColor(.white))),
        TabItem(title: "Scans", icon: "magnifyingglass", view: AnyView(Text("Scans View").foregroundColor(.white)))
    ]

    init() {
        _selectedTab = State(initialValue: tabs[0])
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            selectedTab.view
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.ignoresSafeArea())
            
            if tabBarVisibility.isVisible { // ✅ condition
                CustomTabBarView(selectedTab: $selectedTab, tabs: tabs)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }

    }
}

