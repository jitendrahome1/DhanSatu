import Foundation

class NotificationService {
    static let shared = NotificationService()
    
    private init() {}
    
    // Simulate API call with hardcoded data
    func fetchNotifications() async throws -> [NotificationModel] {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second
        
        return getSampleNotifications()
    }
    
    // Hardcoded sample data matching the screenshot
    private func getSampleNotifications() -> [NotificationModel] {
        return [
            NotificationModel(
                id: "1",
                type: .equity,
                symbol: "EXIDEIND",
                action: .buy,
                currentPrice: 412.65,
                stopLoss: 392.0,
                target: 474.5,
                time: "03:15 pm",
                date: "2025-09-05",
                createdAt: "2025-09-05T15:15:00Z"
            ),
            NotificationModel(
                id: "2",
                type: .options,
                symbol: "ANGELONE 30 SEP 2,300 CALL",
                action: .buy,
                currentPrice: 87.15,
                stopLoss: 54.5,
                target: 185.2,
                time: "03:00 pm",
                date: "2025-09-05",
                createdAt: "2025-09-05T15:00:00Z"
            ),
            NotificationModel(
                id: "3",
                type: .futures,
                symbol: "ANGELONE SEP FUT",
                action: .buy,
                currentPrice: 2307.9,
                stopLoss: 2280.2,
                target: 2391.0,
                time: "03:00 pm",
                date: "2025-09-05",
                createdAt: "2025-09-05T15:00:00Z"
            ),
            NotificationModel(
                id: "4",
                type: .equity,
                symbol: "ANGELONE",
                action: .buy,
                currentPrice: 2298.0,
                stopLoss: 2183.1,
                target: 2642.7,
                time: "03:00 pm",
                date: "2025-09-05",
                createdAt: "2025-09-05T15:00:00Z"
            ),
            NotificationModel(
                id: "5",
                type: .options,
                symbol: "MIDCPNIFTY 30 SEP 12,875 CALL",
                action: .buy,
                currentPrice: 201.35,
                stopLoss: 140.9,
                target: 382.6,
                time: "02:00 pm",
                date: "2025-09-05",
                createdAt: "2025-09-05T14:00:00Z"
            ),
            NotificationModel(
                id: "6",
                type: .futures,
                symbol: "MIDCPNIFTY SEP FUT",
                action: .buy,
                currentPrice: 12871.15,
                stopLoss: 12768.2,
                target: 13180.1,
                time: "02:00 pm",
                date: "2025-09-05",
                createdAt: "2025-09-05T14:00:00Z"
            ),
            // Add some notifications for previous days
            NotificationModel(
                id: "7",
                type: .equity,
                symbol: "RELIANCE",
                action: .buy,
                currentPrice: 2456.80,
                stopLoss: 2350.0,
                target: 2650.0,
                time: "11:30 am",
                date: "2025-09-04",
                createdAt: "2025-09-04T11:30:00Z"
            ),
            NotificationModel(
                id: "8",
                type: .options,
                symbol: "NIFTY 28 SEP 25000 CE",
                action: .sell,
                currentPrice: 125.50,
                stopLoss: 145.0,
                target: 95.0,
                time: "10:15 am",
                date: "2025-09-04",
                createdAt: "2025-09-04T10:15:00Z"
            ),
            NotificationModel(
                id: "18",
                type: .options,
                symbol: "NIFTY 28 SEP 25000 CE",
                action: .sell,
                currentPrice: 125.50,
                stopLoss: 145.0,
                target: 95.0,
                time: "10:15 am",
                date: "2025-09-04",
                createdAt: "2025-09-04T10:15:00Z"
            ),
            NotificationModel(
                id: "16",
                type: .options,
                symbol: "NIFTY 28 SEP 25000 CE",
                action: .sell,
                currentPrice: 125.50,
                stopLoss: 145.0,
                target: 95.0,
                time: "10:15 am",
                date: "2025-09-04",
                createdAt: "2025-09-04T10:15:00Z"
            ),
            NotificationModel(
                id: "17",
                type: .options,
                symbol: "NIFTY 28 SEP 25000 CE",
                action: .sell,
                currentPrice: 125.50,
                stopLoss: 145.0,
                target: 95.0,
                time: "10:15 am",
                date: "2025-09-04",
                createdAt: "2025-09-04T10:15:00Z"
            ),
            NotificationModel(
                id: "9",
                type: .equity,
                symbol: "TCS",
                action: .buy,
                currentPrice: 3890.25,
                stopLoss: 3750.0,
                target: 4150.0,
                time: "02:45 pm",
                date: "2025-09-03",
                createdAt: "2025-09-03T14:45:00Z"
            ),
            NotificationModel(
                id: "10",
                type: .equity,
                symbol: "M&M",
                action: .buy,
                currentPrice: 3890.25,
                stopLoss: 3750.0,
                target: 4150.0,
                time: "02:45 pm",
                date: "2025-09-03",
                createdAt: "2025-09-03T14:45:00Z"
            ),
            NotificationModel(
                id: "11",
                type: .equity,
                symbol: "HCL Fut",
                action: .buy,
                currentPrice: 3890.25,
                stopLoss: 3750.0,
                target: 4150.0,
                time: "02:45 pm",
                date: "2025-09-03",
                createdAt: "2025-09-03T14:45:00Z"
            ),
            NotificationModel(
                id: "12",
                type: .equity,
                symbol: "NSDL",
                action: .buy,
                currentPrice: 3890.25,
                stopLoss: 3750.0,
                target: 4150.0,
                time: "02:45 pm",
                date: "2025-09-03",
                createdAt: "2025-09-03T14:45:00Z"
            )
        ]
    }
    
    // Filter notifications by type
    func filterNotifications(_ notifications: [NotificationModel], by filter: String) -> [NotificationModel] {
        switch filter {
        case "All":
            return notifications
        case "Buy":
            return notifications.filter { $0.action == .buy }
        case "Sell":
            return notifications.filter { $0.action == .sell }
        case "Signals":
            return notifications // All notifications are signals in this context
        default:
            return notifications
        }
    }
}
