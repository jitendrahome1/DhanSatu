import SwiftUI

struct HoldingsView: View {
    @StateObject private var viewModel = HoldingsViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Holdings...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.holdings) { holding in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(holding.tradingSymbol)
                                        .font(.headline)
                                    Text("Qty: \(holding.totalQty) | Avg Price: ₹\(holding.avgCostPrice, specifier: "%.2f")")
                                        .font(.subheadline)
                                    Text("LTP: ₹\(holding.lastTradedPrice, specifier: "%.2f")")
                                        .font(.caption)
                                    // Profit & Loss Calculation
                                    let profitLoss = (holding.lastTradedPrice - holding.avgCostPrice) * Double(holding.totalQty)
                                    let profitLossPercent = (holding.avgCostPrice > 0) ? ((holding.lastTradedPrice - holding.avgCostPrice) / holding.avgCostPrice) * 100 : 0
                                    HStack {
                                        Text(
                                            String(format: "%@₹%.2f (%.2f%%)",
                                                   profitLoss >= 0 ? "+" : "-",
                                                   abs(profitLoss),
                                                   abs(profitLossPercent))
                                        )
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .foregroundColor(profitLoss >= 0 ? .green : .red)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 12)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color(.sRGB, red: 30/255, green: 32/255, blue: 40/255, opacity: 0.95))
                                        .shadow(color: Color.green.opacity(0.18), radius: 8, x: 0, y: 4)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(Color.green, lineWidth: 1.2)
                                        )
                                )
                                .padding(.horizontal, 8)
                            }
                        }
                        .padding(.top, 12)
                        .padding(.bottom, 24)
                    }
                    .background(Color.black.ignoresSafeArea())
                }
            }
            .navigationTitle("Holdings")
            .background(Color.black.ignoresSafeArea())
            .foregroundColor(.white)
            .onAppear {
                viewModel.fetchHoldings()
            }
        }
        .background(Color.black.ignoresSafeArea())
    }
}
