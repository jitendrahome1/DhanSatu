import Foundation

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchOrders() {
        // Use localhost for simulator, IP address for physical device
        #if targetEnvironment(simulator)
        let baseURL = "http://localhost:8000/"
        #else
        // Using the computer's IP address for physical device testing
        let baseURL = "http://192.168.1.8:8000/"
        #endif
        
        guard let url = URL(string: baseURL) else { return }
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
