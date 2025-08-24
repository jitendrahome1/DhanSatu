import SwiftUI

struct StockSignalCardView: View {
    var stockName: String
    var currentPrice: String
    var profitPercent: String
    var stopLoss: String
    var target: String
    var status: String
    var entryDate: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header with stock name and price
            HStack {
                Text(stockName)
                    .font(.headline)
                    .foregroundColor(.white)
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(.orange)
                Spacer()
                VStack(alignment: .trailing) {
                    Text("₹\(currentPrice)")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("-₹10.65 (-1.80%)")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }

            Text("Entry: \(entryDate)")
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
                    Text(profitPercent)
                        .foregroundColor(.green)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Status")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text(status)
                        .foregroundColor(.green)
                }
            }

            // SL and Target
            HStack {
                VStack(alignment: .leading) {
                    Text("Stop Loss")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text("₹\(stopLoss)")
                        .foregroundColor(.white)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text("Target")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text("₹\(target)")
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
