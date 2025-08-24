import SwiftUI

struct LTPView: View {
    @StateObject private var viewModel = LTPViewModel()
    @State private var securityId: String = ""
    @State private var exchangeSegment: String = "NSE"

    var body: some View {
        VStack(spacing: 20) {
            TextField("Security ID", text: $securityId)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Picker("Exchange", selection: $exchangeSegment) {
                Text("NSE").tag("NSE")
                Text("BSE").tag("BSE")
                Text("MCX").tag("MCX")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            Button("Fetch LTP") {
                viewModel.fetchLTP(securityId: securityId, exchangeSegment: exchangeSegment)
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)

            if viewModel.isLoading {
                ProgressView("Fetching LTP...")
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
            } else if let ltp = viewModel.ltp {
                Text("LTP: ₹\(ltp, specifier: "%.2f")")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .navigationTitle("Get LTP")
    }
}
