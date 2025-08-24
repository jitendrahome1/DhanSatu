import SwiftUI

struct AnimatedGradientBorder: View {
    @State private var animate = false

    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(
                AngularGradient(
                    gradient: Gradient(colors: [.yellow, .green, .blue, .yellow]),
                    center: .center,
                    angle: .degrees(animate ? 360 : 0)
                ),
                lineWidth: 1.5
            )
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 2)
                        .repeatForever(autoreverses: false)
                ) {
                    animate = true
                }
            }
    }
}
