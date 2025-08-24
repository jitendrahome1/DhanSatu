import SwiftUI

struct TabSwitcherView: View {
    @State private var selectedTab = "Positions"

    var body: some View {
        HStack(spacing: 0) {
            tabButton(title: "Positions (6)", isSelected: selectedTab == "Positions")
                .onTapGesture { selectedTab = "Positions" }
            tabButton(title: "Holdings (10)", isSelected: selectedTab == "Holdings")
                .onTapGesture { selectedTab = "Holdings" }
        }
        .background(AppColors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal)
    }

    func tabButton(title: String, isSelected: Bool) -> some View {
        Text(title)
            .foregroundColor(isSelected ? .black : .white)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .padding(8)
            .background(isSelected ? AppColors.buttonYellow : Color.clear)
            .cornerRadius(8)
    }
}
