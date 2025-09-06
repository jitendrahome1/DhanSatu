import Foundation

class StockSignalViewModel: ObservableObject {
    @Published var stockSignals: [StockSignal] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Base URL for the Vapor server
    private let baseURL: String = {
        #if targetEnvironment(simulator)
            return "http://localhost:8080"
        #else
            // Using the computer's IP address for physical device testing
            return "http://192.168.1.8:8080"
        #endif
    }()
    
    // Auto-refresh timer
    private var refreshTimer: Timer?
    
    init() {
        fetchStockSignals()
        startAutoRefresh()
    }
    
    deinit {
        stopAutoRefresh()
    }
    
    func fetchStockSignals() {
        guard let url = URL(string: "\(baseURL)/api/signals") else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let newSignals = try decoder.decode([StockSignal].self, from: data)
                    
                    // Merge with existing signals
                    var signalsDict: [String: StockSignal] = [:]
                    if let existingSignals = self?.stockSignals {
                        signalsDict = Dictionary(uniqueKeysWithValues: existingSignals.map { ($0.id, $0) })
                    }
                    
                    for signal in newSignals {
                        signalsDict[signal.id] = signal
                    }
                    
                    // Update the array and sort
                    var updatedSignals = Array(signalsDict.values)
                    updatedSignals.sort { signal1, signal2 in
                        guard let date1 = ISO8601DateFormatter().date(from: signal1.createdAt ?? ""),
                              let date2 = ISO8601DateFormatter().date(from: signal2.createdAt ?? "") else {
                            return false
                        }
                        return date1 > date2
                    }
                    
                    self?.stockSignals = updatedSignals
                    
                } catch {
                    self?.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                    print("Decoding error: \(error)")
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Received JSON: \(jsonString)")
                    }
                }
            }
        }.resume()
    }
    
    func refreshSignals() { fetchStockSignals() }
    
    // Start auto-refresh every 30 seconds
    private func startAutoRefresh() { refreshTimer = Timer.scheduledTimer(withTimeInterval: 15.0, repeats: true) { [weak self] _ in self?.fetchStockSignals() } }
    
    // Stop auto-refresh
    private func stopAutoRefresh() {
        refreshTimer?.invalidate()
        refreshTimer = nil
    }
    
    // Create a new stock signal
    func createStockSignal(stockName: String, currentPrice: Double, profitPercent: Double, 
                          stopLoss: Double, target: Double, status: String, entryDate: String, 
                          completion: @escaping (Bool) -> Void = { _ in }) {
        guard let url = URL(string: "\(baseURL)/api/signals") else {
            errorMessage = "Invalid URL"
            completion(false)
            return
        }
        
        let signalData: [String: Any] = [
            "stockName": stockName,
            "currentPrice": currentPrice,
            "profitPercent": profitPercent,
            "stopLoss": stopLoss,
            "target": target,
            "status": status,
            "entryDate": entryDate
        ]
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: signalData) else {
            errorMessage = "Failed to create request data"
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Failed to create signal: \(error.localizedDescription)"
                    completion(false)
                    return
                }
                
                // Check if the request was successful
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    // Refresh the signals list after creating
                    self?.fetchStockSignals()
                    completion(true)
                } else {
                    self?.errorMessage = "Failed to create signal"
                    completion(false)
                }
            }
        }.resume()
    }
    
    // Delete a stock signal
    func deleteStockSignal(id: String, completion: @escaping (Bool) -> Void = { _ in }) {
        guard let url = URL(string: "\(baseURL)/api/signals/\(id)") else {
            errorMessage = "Invalid URL"
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = "Failed to delete signal: \(error.localizedDescription)"
                    completion(false)
                    return
                }
                
                // Check if the request was successful
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 {
                    // Refresh the signals list after deleting
                    self?.fetchStockSignals()
                    completion(true)
                } else {
                    self?.errorMessage = "Failed to delete signal"
                    completion(false)
                }
            }
        }.resume()
    }
}

// removed sentiment filtering
