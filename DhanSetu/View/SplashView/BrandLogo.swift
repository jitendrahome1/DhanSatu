import SwiftUI

struct BrandLogo: View {
    var size: CGFloat = 120

    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(colors: [Color.white.opacity(0.15), Color.white.opacity(0.05)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: size, height: size)
                .overlay(
                    Circle()
                        .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.2), radius: 10, y: 6)

            VStack(spacing: 4) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: size * 0.32, weight: .bold))
                    .foregroundStyle(.white)
                Text("DhanSetu")
                    .font(.system(size: size * 0.20, weight: .bold, design: .rounded))
                    .kerning(0.5)
                    .foregroundStyle(.white)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("DhanSetu")
    }
}

#Preview {
    ZStack {
        LinearGradient(colors: [.green, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
        BrandLogo(size: 140)
    }
}