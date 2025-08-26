import SwiftUI

struct StockSignalCardView: View {
    let stockSignal: StockSignal
    
    private var statusColor: Color {
        switch stockSignal.status.lowercased() {
        case "active":
            return .green
        case "in buying range":
            return .orange
        case "closed":
            return .red
        default:
            return .gray
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header with stock name and price
            HStack {
                Text(stockSignal.stockName)
                    .font(.headline)
                    .foregroundColor(.white)
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(.orange)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("₹\(stockSignal.formattedCurrentPrice)")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("-₹10.65 (-1.80%)")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            Text("Entry: \(stockSignal.formattedEntryDate)")
                .font(.caption)
                .foregroundColor(.gray)

            // SL to Target bar
            HStack(spacing: 0) {
                Rectangle().fill(Color.red).frame(width: 40, height: 4)
                Rectangle().fill(Color.white).frame(width: 60, height: 4)
                Rectangle().fill(Color.green).frame(height: 4)
            }
            .cornerRadius(2)

            // Profit and Status
            HStack {
                VStack(alignment: .leading) {
                    Text("Potential Profit")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text(stockSignal.formattedProfitPercent)
                        .foregroundColor(.green)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Status")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text(stockSignal.status)
                        .foregroundColor(statusColor)
                }
            }

            // SL and Target
            HStack {
                VStack(alignment: .leading) {
                    Text("Stop Loss")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text("₹\(stockSignal.formattedStopLoss)")
                        .foregroundColor(.white)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Target")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text("₹\(stockSignal.formattedTarget)")
                        .foregroundColor(.white)
                }
            }

            // Trade Now button
            Button(action: {}) {
                Text("Trade Now")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(
            AppColors.cardBackground
                .cornerRadius(12)
                .overlay(
                    AnimatedGradientBorder()
                )
        )
        .padding(.horizontal)
    }
}

#Preview {
    StockSignalCardView(stockSignal: StockSignal(
        id: "1",
        stockName: "ASAL",
        currentPrice: 579.90,
        profitPercent: 19.71,
        stopLoss: 534.00,
        target: 700.00,
        status: "In Buying Range",
        entryDate: "2024-06-23T12:43:00Z",
        createdAt: "2024-06-23T12:43:00Z",
        updatedAt: "2024-06-23T12:43:00Z"
    ))
}
