import SwiftUI

struct NotificationListView: View {
    @StateObject private var viewModel = NotificationViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            // Custom Navigation Header
            CustomNavHeader(
                style: .notification,
                userName: "Notifications",
                greeting: "",
                showProfile: false,
                onBackTapped: {
                    presentationMode.wrappedValue.dismiss()
                },
                onSearchTapped: {
                    // TODO: Implement search functionality
                }
            )
            
            // Filter Bar
            NotificationFilterBar(
                selectedFilter: $viewModel.selectedFilter,
                onFilterChanged: { filter in
                    viewModel.updateFilter(filter)
                }
            )
            
            // Content
            if viewModel.isLoading {
                Spacer()
                ProgressView("Loading notifications...")
                    .foregroundColor(.gray)
                Spacer()
            } else if let errorMessage = viewModel.errorMessage {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 50))
                        .foregroundColor(.orange)
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                    Button("Retry") {
                        viewModel.refreshNotifications()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
                Spacer()
            } else if viewModel.groupedNotifications.isEmpty {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "bell.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No notifications found")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("Check back later for new trading signals")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }
                .padding()
                Spacer()
            } else {
                // Notification List
                ScrollView {
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        ForEach(viewModel.groupedNotifications, id: \.0) { dateGroup in
                            Section {
                                ForEach(dateGroup.1) { notification in
                                    NotificationRowView(notification: notification)
                                        .onTapGesture {
                                            viewModel.markAsRead(notification.id)
                                        }
                                }
                            } header: {
                                NotificationDateHeader(date: dateGroup.0)
                            }
                        }
                    }
                }.scrollIndicators(.hidden)
                .refreshable {
                    viewModel.refreshNotifications()
                }
            }
        }
        .navigationBarHidden(true)
        .background(Color(.systemBackground))
    }
}

// MARK: - Filter Bar Component
struct NotificationFilterBar: View {
    @Binding var selectedFilter: String
    let onFilterChanged: (String) -> Void
    let filters = ["All", "Buy", "Sell", "Signals"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(filters, id: \.self) { filter in
                    FilterChip(
                        title: filter,
                        isSelected: selectedFilter == filter
                    ) {
                        selectedFilter = filter
                        onFilterChanged(filter)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
}

// Using existing FilterChip from SharedComponents

// MARK: - Date Header Component
struct NotificationDateHeader: View {
    let date: String
    
    var body: some View {
        HStack {
            Text(date)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.primary)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
}

// MARK: - Notification Row Component
struct NotificationRowView: View {
    let notification: NotificationModel
    
    var body: some View {
        HStack(spacing: 12) {
            // Logo Circle
            Image(systemName: notification.logoImageName)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(getLogoColor(for: notification.symbol))
                )
            
            // Content
            VStack(alignment: .leading, spacing: 4) {
                // Notification Type with Bell Icon
                HStack(spacing: 6) {
                    Image(systemName: notification.type.icon)
                        .font(.system(size: 12))
                        .foregroundColor(.orange)
                    Text(notification.type.displayName)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.primary)
                }
                
                // Trading Details
                HStack(spacing: 4) {
                    Text(notification.action.displayName)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(getActionColor(notification.action))
                    
                    Text(notification.symbol)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.primary)
                    
                    Text("at")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    
                    Text("₹\(notification.formattedCurrentPrice)")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.primary)
                }
                
                // SL and Target
                HStack(spacing: 8) {
                    Text("SL ₹\(notification.formattedStopLoss)")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    
                    Text("Target ₹\(notification.formattedTarget)")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Right Side
            VStack(alignment: .trailing, spacing: 8) {
                // Time
                Text(notification.formattedTime)
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                
                // Signal Badge
                Text("Signal")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .fill(Color.green)
                    )
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
    
    private func getLogoColor(for symbol: String) -> Color {
        // Generate a consistent color based on symbol
        let colors: [Color] = [.blue, .purple, .orange, .red, .green, .pink, .indigo]
        let index = abs(symbol.hashValue) % colors.count
        return colors[index]
    }
    
    private func getActionColor(_ action: NotificationModel.ActionType) -> Color {
        switch action {
        case .buy:
            return .green
        case .sell:
            return .red
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        NotificationListView()
    }
}
