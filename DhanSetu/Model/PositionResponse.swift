import Foundation

struct PositionResponse: Codable, Identifiable {
    // Use securityId or generate a UUID() if no unique id
    var id: String { securityId }

    let dhanClientId: String
    let tradingSymbol: String
    let securityId: String
    let positionType: String
    let exchangeSegment: String
    let productType: String
    let buyAvg: Double
    let costPrice: Double
    let buyQty: Int
    let sellAvg: Double
    let sellQty: Int
    let netQty: Int
    let realizedProfit: Double
    let unrealizedProfit: Double
    let rbiReferenceRate: Double
    let multiplier: Int
    let carryForwardBuyQty: Int
    let carryForwardSellQty: Int
    let carryForwardBuyValue: Double
    let carryForwardSellValue: Double
    let dayBuyQty: Int
    let daySellQty: Int
    let dayBuyValue: Double
    let daySellValue: Double
    let drvExpiryDate: String
    let drvOptionType: String
    let drvStrikePrice: Double
    let crossCurrency: Bool

    // If you want to convert drvExpiryDate to Date you can add a custom Date formatter here.
}
