struct OrderListResponse: Codable {
    let status: String
    let remarks: String
    let data: [Order]
}

struct Order: Codable, Identifiable {
    var id: String { orderId }
    let dhanClientId: String
    let orderId: String
    let exchangeOrderId: String
    let correlationId: String
    let orderStatus: String
    let transactionType: String
    let exchangeSegment: String
    let productType: String
    let orderType: String
    let validity: String
    let tradingSymbol: String
    let securityId: String
    let quantity: Int
    let disclosedQuantity: Int
    let price: Double
    let triggerPrice: Double
    let afterMarketOrder: Bool
    let boProfitValue: Double
    let boStopLossValue: Double
    let legName: String
    let createTime: String
    let updateTime: String
    let exchangeTime: String
    let drvExpiryDate: String
    let drvOptionType: String
    let drvStrikePrice: Double
    let omsErrorCode: String
    let omsErrorDescription: String
    let algoId: String
    let remainingQuantity: Int
    let averageTradedPrice: Double
    let filledQty: Int
}
