import Foundation

@MainActor
final class FundLimitsViewModel: ObservableObject {
    @Published var fundLimits: FundLimitsResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let dhan = DhanHQManager.shared

    func fetchFundLimits() async {
        isLoading = true
        errorMessage = nil
        do {
            let data = try await dhan.getFundLimitsAsync()
            self.fundLimits = data
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
