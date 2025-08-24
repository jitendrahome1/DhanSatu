import SwiftUI

struct OverallPLCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Overall P&L")
                        .foregroundColor(.white)
                        .font(.subheadline)
                    Text("-₹3,910.00")
                        .foregroundColor(AppColors.lossRed)
                        .font(.title3)
                        .fontWeight(.bold)
                    Text("On 6 positions")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                Spacer()
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(.gray)
            }
            HStack {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(AppColors.verifiedBlue)
                Text("P&L for Tue 01 Jul, 2025 · Verified by Stockwiz · 11:10 PM")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Spacer()
            }
            HStack {
                Circle()
                    .fill(.green)
                    .frame(width: 8, height: 8)
                Text("Broker Connected")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName: "arrow.clockwise")
                    .foregroundColor(.yellow)
                Text("Refresh Now")
                    .font(.caption2)
                    .foregroundColor(.yellow)
            }
        }
        
        .padding()
       // .background(AppColors.cardBackground)
      //  .cornerRadius(12)
       // .padding(.horizontal)
        .background(
            AppColors.cardBackground
                .cornerRadius(12)
                .overlay(
                    AnimatedGradientBorder()
                )
        )
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)
        .padding(.horizontal)
    }
}
