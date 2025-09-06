import SwiftUI

enum NavHeaderStyle {
    case home         // greeting, search, notification
    case settings     // back button, title, toggle
    case notification // back button, title, search
}

struct CustomNavHeader: View {
    let style: NavHeaderStyle
    let userName: String
    let greeting: String
    let showProfile: Bool
    let onBackTapped: (() -> Void)?
    let onSearchTapped: (() -> Void)?
    let onNotificationTapped: (() -> Void)?
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    init(
        style: NavHeaderStyle = .home,
        userName: String = "Ayush",
        greeting: String = "Hello",
        showProfile: Bool = true,
        onBackTapped: (() -> Void)? = nil,
        onSearchTapped: (() -> Void)? = nil,
        onNotificationTapped: (() -> Void)? = nil
    ) {
        self.style = style
        self.userName = userName
        self.greeting = greeting
        self.showProfile = showProfile
        self.onBackTapped = onBackTapped
        self.onSearchTapped = onSearchTapped
        self.onNotificationTapped = onNotificationTapped
    }
    
    var body: some View {
        HStack {
            switch style {
            case .home:
                HStack(spacing: 12) {
                    if showProfile {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.title2)
                                .foregroundColor(.accentColor)
                            
                            Text("\(greeting), \(userName) !")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                    } else {
                        Text("\(greeting), \(userName) !")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                HStack(spacing: 20) {
                    Button(action: { onSearchTapped?() }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                    Button(action: { onNotificationTapped?() }) {
                        Image(systemName: "bell")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                }
                
            case .settings:
                Button(action: { onBackTapped?() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.blue)
                }
                Text("Settings")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Toggle("", isOn: $isDarkMode)
                    .toggleStyle(SwitchToggleStyle(tint: .green))
                    .labelsHidden()
                    .frame(width: 50)
                    
            case .notification:
                Button(action: { onBackTapped?() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.blue)
                }
                Text("Notification")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Button(action: { onSearchTapped?() }) {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
}
