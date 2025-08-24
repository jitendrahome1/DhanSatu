import Foundation

public extension DhanHQ {
    internal func getFundLimitsAsync() async throws -> FundLimitsResponse {
        try await withCheckedThrowingContinuation { continuation in
            self.getFundLimits { (result: Result<FundLimitsResponse, Error>) in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    internal func getPositionsAsync() async throws -> [PositionResponse] {
        try await withCheckedThrowingContinuation { continuation in
            self.getPositions { (result: Result<[PositionResponse], Error>) in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}


