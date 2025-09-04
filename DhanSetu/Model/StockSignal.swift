import Foundation

struct StockSignal: Codable, Identifiable {
    let id: String
    let stockName: String
    let currentPrice: Double
    let profitPercent: Double
    let stopLoss: Double
    let target: Double
    let status: String
    let entryDate: String
    let createdAt: String?
    let updatedAt: String?
    
    // Computed properties for formatted display
    var formattedCurrentPrice: String {
        return String(format: "%.2f", currentPrice)
    }
    
    var formattedProfitPercent: String {
        return String(format: "%.2f%%", profitPercent)
    }
    
    var formattedStopLoss: String {
        return String(format: "%.2f", stopLoss)
    }
    
    var formattedTarget: String {
        return String(format: "%.2f", target)
    }
    
    var formattedEntryDate: String {
        // Convert ISO8601 date string to readable format
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: entryDate) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return entryDate
    }
    
    // Status color for UI
    var statusColor: String {
        switch status.lowercased() {
        case "active":
            return "green"
        case "in buying range":
            return "orange"
        case "closed":
            return "red"
        default:
            return "gray"
        }
    }
}
