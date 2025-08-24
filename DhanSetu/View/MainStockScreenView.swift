import SwiftUI

struct MainStockScreenView: View {
    @State private var selectedTab = "All"

    var body: some View {
        NavigationStack {   // 👈 Wrap your whole content in NavigationStack
            VStack(spacing: 16) {
                TopBarView()  // This contains NavigationLink for Settings

                DhanMarginHeaderView()

                TabSelectionView(selected: $selectedTab)

                ScrollView {
                    StockSignalCardView(
                        stockName: "ASAL",
                        currentPrice: "579.90",
                        profitPercent: "19.71%",
                        stopLoss: "534.00",
                        target: "700.00",
                        status: "In Buying Range",
                        entryDate: "23 Jun, 12:43 PM"
                    )
                    .padding(.top)
                }

                Spacer()
            }
            .padding(.top, platformTopPadding)
            .background(Color.black)
            .foregroundColor(.white)
            .frame(minWidth: 400, idealWidth: 600, maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var platformTopPadding: CGFloat {
        #if os(iOS)
        return 0
        #else
        return 20
        #endif
    }
}
