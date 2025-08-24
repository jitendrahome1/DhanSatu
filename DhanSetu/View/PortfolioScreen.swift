import SwiftUI

struct PortfolioScreen: View {
    @StateObject private var viewModel = PositionsViewModel()

    var body: some View {
        VStack(spacing: 12) {
            ProfileHeaderView()
            TabSwitcherView()
            OverallPLCardView()
            PositionFilterTabs()
            Text("Closed Positions")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            ClosedPositionCardView()
            Spacer()
        }
        .background(AppColors.background.ignoresSafeArea())
        .onAppear {
            Task {
                await viewModel.getPositions()
            }
        }
    }
}
