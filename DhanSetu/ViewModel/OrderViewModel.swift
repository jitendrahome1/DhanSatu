import Foundation

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchOrders() {
        guard let url = URL(string: "http://localhost:8000/") else { return }
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
                    let decoded = try JSONDecoder().decode(OrderListResponse.self, from: data)
                    self.orders = decoded.data
                } catch {
                    self.errorMessage = "Failed to decode: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
