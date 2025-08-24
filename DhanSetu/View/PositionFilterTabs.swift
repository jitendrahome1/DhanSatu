import SwiftUI

struct PositionFilterTabs: View {
    @State private var selected = "Closed"

    var body: some View {
        HStack {
            ForEach(["All", "Open", "Closed"], id: \.self) { title in
                Text(title)
                    .font(.caption)
                    .foregroundColor(selected == title ? .black : .white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(selected == title ? Color.white : Color.clear)
                    .cornerRadius(6)
                    .onTapGesture { selected = title }
            }
        }
        .background(AppColors.cardBackground)
        .cornerRadius(8)
        .padding(.horizontal)
    }
}
