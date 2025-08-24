import Foundation

struct HoldingsResponse: Codable {
    let status: String
    let remarks: String
    let data: [Holding]
}

struct Holding: Codable, Identifiable {
    // Use securityId as unique identifier
    var id: String { securityId }

    let exchange: String
    let tradingSymbol: String
    let securityId: String
    let isin: String
    let totalQty: Int
    let dpQty: Int
    let t1Qty: Int
    let mtf_t1_qty: Int
    let mtf_qty: Int
    let availableQty: Int
    let collateralQty: Int
    let avgCostPrice: Double
    let lastTradedPrice: Double
}
