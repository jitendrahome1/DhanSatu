import SwiftUI

struct CustomNavHeader: View {
    let userName: String
    let greeting: String
    let onSearchTapped: (() -> Void)?
    let onNotificationTapped: (() -> Void)?
    
    // Default initializer with most common use case
    init(
        userName: String = "Ayush",
        greeting: String = "Hello",
        onSearchTapped: (() -> Void)? = nil,
        onNotificationTapped: (() -> Void)? = nil
    ) {
        self.userName = userName
        self.greeting = greeting
        self.onSearchTapped = onSearchTapped
        self.onNotificationTapped = onNotificationTapped
    }
    
    var body: some View {
        HStack {
            HStack(spacing: 12) {
                // User Avatar
                Image(systemName: "person.crop.circle.fill")
                    .font(.title2)
                    .foregroundColor(.brown)
                
                Text("\(greeting), \(userName) !")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                // Search Button
                Button(action: {
                    onSearchTapped?()
                }) {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                        .foregroundColor(.primary)
                }
                
                // Notification Button
                Button(action: {
                    onNotificationTapped?()
                }) {
                    Image(systemName: "bell")
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

// MARK: - Preview
#Preview {
    VStack {
        CustomNavHeader()
        
        Divider()
        
        CustomNavHeader(
            userName: "Jitendra",
            greeting: "Welcome",
            onSearchTapped: {
                print("Search tapped")
            },
            onNotificationTapped: {
                print("Notification tapped")
            }
        )
        
        Spacer()
    }
}
