import SwiftUI

struct CreateStockSignalView: View {
    @StateObject private var viewModel = StockSignalViewModel()
    @Environment(\.dismiss) private var dismiss
    
    @State private var stockName = ""
    @State private var currentPrice = ""
    @State private var profitPercent = ""
    @State private var stopLoss = ""
    @State private var target = ""
    @State private var status = "In Buying Range"
    @State private var entryDate = Date()
    
    private let statusOptions = ["In Buying Range", "Active", "Closed"]
    
    var body: some View {
        NavigationView {
            ZStack {
                AppColors.cardBackground
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Stock Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Stock Name")
                                .foregroundColor(.white)
                                .font(.headline)
                            TextField("Enter stock name", text: $stockName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundColor(.black)
                        }
                        
                        // Current Price
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Current Price")
                                .foregroundColor(.white)
                                .font(.headline)
                            TextField("Enter current price", text: $currentPrice)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                                .foregroundColor(.black)
                        }
                        
                        // Profit Percent
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Profit Percent")
                                .foregroundColor(.white)
                                .font(.headline)
                            TextField("Enter profit percent", text: $profitPercent)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                                .foregroundColor(.black)
                        }
                        
                        // Stop Loss
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Stop Loss")
                                .foregroundColor(.white)
                                .font(.headline)
                            TextField("Enter stop loss", text: $stopLoss)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                                .foregroundColor(.black)
                        }
                        
                        // Target
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Target")
                                .foregroundColor(.white)
                                .font(.headline)
                            TextField("Enter target", text: $target)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                                .foregroundColor(.black)
                        }
                        
                        // Status
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Status")
                                .foregroundColor(.white)
                                .font(.headline)
                            Picker("Status", selection: $status) {
                                ForEach(statusOptions, id: \.self) { option in
                                    Text(option).tag(option)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        // Entry Date
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Entry Date")
                                .foregroundColor(.white)
                                .font(.headline)
                            DatePicker("Entry Date", selection: $entryDate, displayedComponents: [.date, .hourAndMinute])
                                .datePickerStyle(CompactDatePickerStyle())
                                .colorScheme(.dark)
                        }
                        
                        // Create Button
                        Button(action: createSignal) {
                            HStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .scaleEffect(0.8)
                                }
                                Text(viewModel.isLoading ? "Creating..." : "Create Signal")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                        }
                        .disabled(!isFormValid || viewModel.isLoading)
                        .opacity((isFormValid && !viewModel.isLoading) ? 1.0 : 0.6)
                        
                        if let errorMessage = viewModel.errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Create Signal")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white)
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !stockName.isEmpty &&
        !currentPrice.isEmpty &&
        !profitPercent.isEmpty &&
        !stopLoss.isEmpty &&
        !target.isEmpty &&
        !status.isEmpty
    }
    
    private func createSignal() {
        guard let currentPriceDouble = Double(currentPrice),
              let profitPercentDouble = Double(profitPercent),
              let stopLossDouble = Double(stopLoss),
              let targetDouble = Double(target) else {
            return
        }
        
        let dateFormatter = ISO8601DateFormatter()
        let entryDateString = dateFormatter.string(from: entryDate)
        
        // Show loading state
        viewModel.isLoading = true
        
        viewModel.createStockSignal(
            stockName: stockName,
            currentPrice: currentPriceDouble,
            profitPercent: profitPercentDouble,
            stopLoss: stopLossDouble,
            target: targetDouble,
            status: status,
            entryDate: entryDateString
        ) { success in
            DispatchQueue.main.async {
                viewModel.isLoading = false
                if success {
                    // Dismiss the view after successful creation
                    dismiss()
                }
                // If failed, error message will be shown by the viewModel
            }
        }
    }
}

#Preview {
    CreateStockSignalView()
}
