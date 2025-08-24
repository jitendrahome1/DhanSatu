//import Foundation
//import Combine
//
//class FundLimitsViewModelOld: ObservableObject {
//    @Published var availableBalance: Double?
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//
//    private var timer: Timer?
//
//    func startAutoRefresh(interval: TimeInterval = AppConstants.RefreshInterval) {
//        // Invalidate previous timer if any
//        timer?.invalidate()
//        // Fetch immediately
//        fetchFundLimits()
//        // Start timer
//        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
//            self?.fetchFundLimits()
//        }
//    }
//
//    func stopAutoRefresh() {
//        timer?.invalidate()
//        timer = nil
//    }
//
//    func fetchFundLimits() {
//        guard let url = URL(string: "http://localhost:8000/fund_limits") else { return }
//        isLoading = true
//        errorMessage = nil
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            DispatchQueue.main.async {
//                self.isLoading = false
//                if let error = error {
//                    self.errorMessage = "Server not available: \(error.localizedDescription)"
//                    self.availableBalance = nil
//                    return
//                }
//                guard let data = data else {
//                    self.errorMessage = "No data"
//                    self.availableBalance = nil
//                    return
//                }
//                do {
//                    let decoded = try JSONDecoder().decode(FundLimitsResponse.self, from: data)
//                    self.availableBalance = decoded.data.availabelBalance
//                    self.errorMessage = nil
//                } catch {
//                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
//                    self.availableBalance = nil
//                }
//            }
//        }.resume()
//    }
//
//    deinit {
//        stopAutoRefresh()
//    }
//}
