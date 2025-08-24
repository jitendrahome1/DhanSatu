import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: TabItem
    let tabs: [TabItem]

    var body: some View {
        VStack(spacing: 0) {
            // ✅ Thin separator line on top
            Rectangle()
                .fill(Color.gray)
                .frame(height: 0.5)
                .frame(maxWidth: .infinity)

            HStack {
                ForEach(tabs, id: \.self) { tab in
                    Spacer()
                    Button(action: {
                        selectedTab = tab
                    }) {
                        VStack(spacing: 4) {
                            if tab.title == "SW" {
                                ZStack {
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: 36, height: 36)
                                    Image(systemName: "circle.fill") // replace with real logo
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(selectedTab == tab ? .green : .gray)
                                }
                            } else {
                                Image(systemName: tab.icon)
                                    .font(.system(size: 18))
                                    .foregroundColor(selectedTab == tab ? .green : .gray)
                            }

                            Text(tab.title)
                                .font(.caption2)
                                .foregroundColor(selectedTab == tab ? .green : .gray)
                        }
                    }
                    Spacer()
                }
            }
            .padding(.vertical, 8)
        }
    }
}
