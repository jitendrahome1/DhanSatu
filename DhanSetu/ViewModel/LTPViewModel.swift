import Foundation
import Combine

class LTPViewModel: ObservableObject {
    @Published var ltp: Double?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchLTP(securityId: String, exchangeSegment: String) {
        guard let url = URL(string: "http://localhost:8000/ltp?security_id=\(securityId)&exchange_segment=\(exchangeSegment)") else {
            self.errorMessage = "Invalid URL"
            return
        }
        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = "Server not available: \(error.localizedDescription)"
                    self.ltp = nil
                    return
                }
                guard let data = data else {
                    self.errorMessage = "No data"
                    self.ltp = nil
                    return
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                       let ltp = json["lastTradedPrice"] as? Double {
                        self.ltp = ltp
                        self.errorMessage = nil
                    } else {
                        self.errorMessage = "Invalid response"
                        self.ltp = nil
                    }
                } catch {
                    self.errorMessage = "Decoding error: \(error.localizedDescription)"
                    self.ltp = nil
                }
            }
        }.resume()
    }
}
