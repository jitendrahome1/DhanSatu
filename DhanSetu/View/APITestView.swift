import SwiftUI

struct APITestView: View {
    @StateObject private var viewModel = StockSignalViewModel()
    @State private var testMessage = "Testing API connection..."
    
    var body: some View {
        VStack(spacing: 20) {
            Text("API Connection Test")
                .font(.title)
                .foregroundColor(.white)
            
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .foregroundColor(.white)
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Image(systemName: "xmark.circle")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                    Text("Connection Failed")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }
            } else {
                VStack {
                    Image(systemName: "checkmark.circle")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                    Text("Connection Successful!")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Found \(viewModel.stockSignals.count) signals")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Button("Test Connection") {
                viewModel.fetchStockSignals()
            }
            .foregroundColor(.blue)
            .padding()
            
            if !viewModel.stockSignals.isEmpty {
                Text("Sample Signal:")
                    .font(.headline)
                    .foregroundColor(.white)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Stock: \(viewModel.stockSignals[0].stockName)")
                        .foregroundColor(.white)
                    Text("Price: ₹\(viewModel.stockSignals[0].formattedCurrentPrice)")
                        .foregroundColor(.white)
                    Text("Status: \(viewModel.stockSignals[0].status)")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.black)
        .onAppear {
            viewModel.fetchStockSignals()
        }
    }
}

#Preview {
    APITestView()
}
