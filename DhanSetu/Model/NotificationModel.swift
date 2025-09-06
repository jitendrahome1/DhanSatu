import Foundation

struct NotificationModel: Codable, Identifiable, Equatable {
    let id: String
    let type: NotificationType
    let symbol: String
    let action: ActionType
    let currentPrice: Double
    let stopLoss: Double
    let target: Double
    let time: String
    let date: String
    let createdAt: String?
    
    enum NotificationType: String, Codable, CaseIterable {
        case equity = "New AI Equity Signal Alert"
        case options = "New AI Options Signal Alert"
        case futures = "New AI Futures Signal Alert"
        
        var displayName: String {
            return self.rawValue
        }
        
        var icon: String {
            return "bell.fill"
        }
    }
    
    enum ActionType: String, Codable, CaseIterable {
        case buy = "Buy"
        case sell = "Sell"
        
        var displayName: String {
            return self.rawValue
        }
        
        var color: String {
            switch self {
            case .buy:
                return "green"
            case .sell:
                return "red"
            }
        }
    }
    
    // Computed properties for formatted display
    var formattedCurrentPrice: String {
        return String(format: "%.2f", currentPrice)
    }
    
    var formattedStopLoss: String {
        return String(format: "%.2f", stopLoss)
    }
    
    var formattedTarget: String {
        return String(format: "%.2f", target)
    }
    
    var formattedTime: String {
        // Convert time string to readable format if needed
        return time
    }
    
    var formattedDate: String {
        // Convert date string to readable format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: date) {
            formatter.dateFormat = "dd MMM yyyy"
            return formatter.string(from: date)
        }
        return date
    }
    
    // Logo image name based on symbol
    var logoImageName: String {
        // For now, return a default system image
        // Later this can be mapped to actual company logos
        return "building.2.crop.circle.fill"
    }
    
    // Filter category for filtering
    var filterCategory: String {
        switch type {
        case .equity:
            return "Signals"
        case .options:
            return "Signals"
        case .futures:
            return "Signals"
        }
    }
}

// Extension for grouping notifications by date
extension Array where Element == NotificationModel {
    func groupedByDate() -> [(String, [NotificationModel])] {
        let grouped = Dictionary(grouping: self) { notification in
            notification.formattedDate
        }
        
        return grouped.sorted { first, second in
            // Sort by date descending (newest first)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            let firstDate = formatter.date(from: first.key) ?? Date.distantPast
            let secondDate = formatter.date(from: second.key) ?? Date.distantPast
            return firstDate > secondDate
        }
    }
}