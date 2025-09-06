import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    var body: some View {
        MainTabView()
            .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
}
