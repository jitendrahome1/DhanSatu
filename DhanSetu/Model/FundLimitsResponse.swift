struct FundLimitsResponse: Codable {
    let dhanClientId: String
    let availableBalance: Double
    let sodLimit: Double
    let collateralAmount: Double
    let receiveableAmount: Double
    let utilizedAmount: Double
    let blockedPayoutAmount: Double
    let withdrawableBalance: Double

    enum CodingKeys: String, CodingKey {
        case dhanClientId
        case availableBalance = "availabelBalance"   // handle API typo
        case sodLimit
        case collateralAmount
        case receiveableAmount
        case utilizedAmount
        case blockedPayoutAmount
        case withdrawableBalance
    }
}
