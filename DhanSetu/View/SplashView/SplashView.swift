import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            AuthRootView()
        } else {
            ZStack {
                Color(AppColors.cardBackground) // Use your dark blue background
                    .ignoresSafeArea()
                
                VStack {
                    Image("splashScreen") // Add your splash logo in Assets
                        .resizable()
                        .scaledToFit()
                    
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.scale = 1.0
                                self.opacity = 1.0
                            }
                        }
                    
                    Text("Dhansatu")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 12)
                }
            }
            .onAppear {
                // Delay before moving to main screen
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("Main App Content Here")
            .font(.title)
            .padding()
    }
}
