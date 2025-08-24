import SwiftUI

struct DhanMarginHeaderView: View {
    @StateObject private var viewModel = FundLimitsViewModel()

    var body: some View {
        VStack(spacing: 8) {
            // Header
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "d.circle.fill")
                        .foregroundColor(.green)
                        .font(.system(size: 22))
                    Text("Dhan")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("Margin Available")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Image(systemName: "eye.fill")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    if let balance = viewModel.fundLimits?.availableBalance {
                        Text("₹\(String(format: "%.2f", balance))")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    } else if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    } else {
                        Text("—")
                            .foregroundColor(.white)
                    }
                }
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
                await viewModel.fetchFundLimits()
            }
        }
    }
}
