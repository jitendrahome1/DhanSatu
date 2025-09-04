import SwiftUI

struct NotificationView: View {
    let message: String
    let type: NotificationType
    @Binding var isShowing: Bool
    
    enum NotificationType {
        case success
        case error
        
        var color: Color {
            switch self {
            case .success:
                return .green
            case .error:
                return .red
            }
        }
        
        var icon: String {
            switch self {
            case .success:
                return "checkmark.circle.fill"
            case .error:
                return "xmark.circle.fill"
            }
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: type.icon)
                .foregroundColor(type.color)
            Text(message)
                .foregroundColor(.white)
                .font(.caption)
            Spacer()
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(8)
        .padding(.horizontal)
        .transition(.move(edge: .top).combined(with: .opacity))
        .onAppear {
            // Auto-dismiss after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isShowing = false
                }
            }
        }
    }
}

#Preview {
    NotificationView(
        message: "Signal created successfully!",
        type: .success,
        isShowing: .constant(true)
    )
}

