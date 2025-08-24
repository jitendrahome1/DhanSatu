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
                        Color(AppColors.cardBackground)
                            .ignoresSafeArea()
                        
                        VStack(spacing: 16) {
                            Image("splashScreen")
                                .resizable()
                                .scaledToFit()
                                .frame(width: size * 0.5, height: size * 0.5)
                                .scaleEffect(animate ? 1.0 : 0.85)
                                .opacity(animate ? 1.0 : 0.6)
                            
                            Text("Dhansatu")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                                .opacity(animate ? 1 : 0)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
                .task {
                    withAnimation(.easeOut(duration: 0.8)) { animate = true }
                    try? await Task.sleep(nanoseconds: 1_600_000_000)
                    withAnimation { isActive = true }
                }
                .statusBar(hidden: true)
            }
        }
    }
}
