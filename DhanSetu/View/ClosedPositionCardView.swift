import SwiftUI

struct ClosedPositionCardView: View {
    @StateObject private var viewModel = PositionsViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "circle.fill")
                        .foregroundColor(.green)
                    Text("NIFTY")
                        .foregroundColor(.white)
                        .fontWeight(.medium)
                    Image(systemName: "n.circle.fill")
                        .foregroundColor(.orange)
                }
                Spacer()
                Text("+₹5,126.25")
                    .foregroundColor(AppColors.profitGreen)
                    .fontWeight(.bold)
            }

            Text("NIFTY 3 JUL 25400 PUT")
                .font(.caption)
                .foregroundColor(.white)

            Text("375 X Avg. ₹71.37")
                .font(.caption2)
                .foregroundColor(.gray)

            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
                .frame(maxWidth: .infinity)

            HStack(spacing: 6) {
                badge(text: "Closed", color: Color.yellow)
                badge(text: "Margin", color: Color.yellow)
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
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)
        .padding(.horizontal)
        .onAppear {
            Task {
                await viewModel.getPositions()
            }
        }
    }

    func badge(text: String, color: Color) -> some View {
        Text(text)
            .font(.caption2)
            .foregroundColor(.black)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(color)
            .cornerRadius(4)
    }
}
