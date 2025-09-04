import SwiftUI

struct PlaceOrderView: View {
    @State private var stockName = ""
    @State private var exchangeSegment = "NSE"
    @State private var transactionType = "BUY"
    @State private var quantity = ""
    @State private var orderType = "MARKET"
    @State private var productType = "INTRA"
    @State private var price = ""
    @State private var resultMessage = ""
    @State private var isPlacingOrder = false

    let stockNameToSecurityId: [String: String] = [
        "HDFCBANK": "1333",
        "RELIANCE": "2885"
        // Add more mappings as needed
    ]

    var body: some View {
        Form {
            Section(header: Text("Order Details")) {
                TextField("Stock Name (e.g. HDFCBANK)", text: $stockName)

                Picker("Exchange Segment", selection: $exchangeSegment) {
                    Text("NSE").tag("NSE")
                    Text("BSE").tag("BSE")
                }
                .pickerStyle(SegmentedPickerStyle())

                Picker("Transaction Type", selection: $transactionType) {
                    Text("BUY").tag("BUY")
                    Text("SELL").tag("SELL")
                }
                .pickerStyle(SegmentedPickerStyle())

                TextField("Quantity", text: $quantity)
                 //   .keyboardType(.numberPad)
                    .onChange(of: quantity) { newValue in
                        quantity = newValue.filter { $0.isNumber }
                    }

                Picker("Order Type", selection: $orderType) {
                    Text("MARKET").tag("MARKET")
                    Text("LIMIT").tag("LIMIT")
                }
                .pickerStyle(SegmentedPickerStyle())

                Picker("Product Type", selection: $productType) {
                    Text("INTRA").tag("INTRA")
                    Text("DELIVERY").tag("DELIVERY")
                }
                .pickerStyle(SegmentedPickerStyle())

                TextField("Price (0 for MARKET)", text: $price)
                   // .keyboardType(.decimalPad)
            }

            Button(action: placeOrder) {
                if isPlacingOrder {
                    ProgressView()
                } else {
                    Text("Place Order")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
            }
            .disabled(isPlacingOrder)

            if !resultMessage.isEmpty {
                Text(resultMessage)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .navigationTitle("Place Order")
        .padding()
    }

    func placeOrder() {
        // Use localhost for simulator, IP address for physical device
        #if targetEnvironment(simulator)
        let baseURL = "http://localhost:8000/place_order"
        #else
        // Using the computer's IP address for physical device testing
        let baseURL = "http://192.168.1.8:8000/place_order"
        #endif
        
        guard let securityId = stockNameToSecurityId[stockName.uppercased()],
              let qty = Int(quantity),
              let prc = Double(price),
              let url = URL(string: baseURL)
        else {
            resultMessage = "Invalid input"
            return
        }

        let order: [String: Any] = [
            "security_id": securityId,
            "exchange_segment": exchangeSegment,
            "transaction_type": transactionType,
            "quantity": qty,
            "order_type": orderType,
            "product_type": productType,
            "price": prc
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: order)

        isPlacingOrder = true
        resultMessage = ""

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isPlacingOrder = false
                if let error = error {
                    resultMessage = "Error: \(error.localizedDescription)"
                } else if let data = data,
                          let responseString = String(data: data, encoding: .utf8) {
                    resultMessage = "Response: \(responseString)"
                } else {
                    resultMessage = "Unknown error"
                }
            }
        }.resume()
    }
}
