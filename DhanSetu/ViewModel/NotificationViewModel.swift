import Foundation

class NotificationViewModel: ObservableObject {
    @Published var notifications: [NotificationModel] = []
    @Published var filteredNotifications: [NotificationModel] = []
    @Published var groupedNotifications: [(String, [NotificationModel])] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedFilter = "All"
    
    private let notificationService = NotificationService.shared
    
    init() {
        Task {
            await fetchNotifications()
        }
    }
    
    @MainActor
    func fetchNotifications() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let fetchedNotifications = try await notificationService.fetchNotifications()
                
                await MainActor.run {
                    self.notifications = fetchedNotifications
                    self.applyFilter()
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = "Failed to load notifications: \(error.localizedDescription)"
                    self.isLoading = false
                }
            }
        }
    }
    
    func updateFilter(_ filter: String) {
        selectedFilter = filter
        applyFilter()
    }
    
    private func applyFilter() {
        filteredNotifications = notificationService.filterNotifications(notifications, by: selectedFilter)
        groupedNotifications = filteredNotifications.groupedByDate()
    }
    
    @MainActor
    func refreshNotifications() {
        Task {
            await fetchNotifications()
        }
    }
    
    // Get notification count for each filter
    func getFilterCount(for filter: String) -> Int {
        return notificationService.filterNotifications(notifications, by: filter).count
    }
    
    // Mark notification as read (for future implementation)
    func markAsRead(_ notificationId: String) {
        // This can be implemented when connecting to real API
        print("Marking notification \(notificationId) as read")
    }
    
    // Delete notification (for future implementation)
    func deleteNotification(_ notificationId: String) {
        notifications.removeAll { $0.id == notificationId }
        applyFilter()
    }
}