import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var animate = false
    
    var body: some View {
        Group {
            if isActive {
                AuthRootView()
            } else {
                GeometryReader { proxy in
                    let size = min(proxy.size.width, proxy.size.height)
                    ZStack {
                        LinearGradient(
                            colors: [Color(AppColors.splashBackground).opacity(1.0), Color.black.opacity(0.85)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .ignoresSafeArea()
                        
                        // Subtle decorative circles
                        Circle()
                            .fill(Color.white.opacity(0.06))
                            .frame(width: size * 0.9, height: size * 0.9)
                            .blur(radius: 60)
                            .offset(x: -size * 0.25, y: -size * 0.35)
                        Circle()
                            .fill(Color.white.opacity(0.05))
                            .frame(width: size * 0.7, height: size * 0.7)
                            .blur(radius: 50)
                            .offset(x: size * 0.3, y: size * 0.4)
                        
                        VStack(spacing: 20) {
                            BrandLogo(size: size * 0.42)
                                .scaleEffect(animate ? 1.0 : 0.8)
                                .opacity(animate ? 1.0 : 0.0)
                                .shadow(color: .black.opacity(0.35), radius: 16, y: 8)
                            Text("Building wealth, one bridge at a time")
                                .font(.footnote.weight(.medium))
                                .foregroundStyle(.white.opacity(0.85))
                                .opacity(animate ? 1 : 0)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
                .task {
                    withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) { animate = true }
                    try? await Task.sleep(nanoseconds: 1_400_000_000)
                    withAnimation { isActive = true }
                }
                .statusBar(hidden: true)
            }
        }
    }
}
