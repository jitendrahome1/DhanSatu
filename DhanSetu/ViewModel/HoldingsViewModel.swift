import Foundation

class HoldingsViewModel: ObservableObject {
    @Published var holdings: [Holding] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchHoldings() {
        guard let url = URL(string: "http://localhost:8000/holdings") else { return }
        isLoading = true
        errorMessage = nil
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let data = data else {
                    self.errorMessage = "No data"
                    return
                }
                do {
                    let decoded = try JSONDecoder().decode(HoldingsResponse.self, from: data)
                    self.holdings = decoded.data
                } catch {
                    self.errorMessage = "Failed to decode: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
