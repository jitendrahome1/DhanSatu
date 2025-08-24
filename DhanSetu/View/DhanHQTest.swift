import SwiftUI

struct DhanOrderListView: View {
    @StateObject private var viewModel = DhanHQViewModel()

    var body: some View {
        VStack {
            if let orders = viewModel.orderList {
                Text("Orders: \(orders.description)")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
            } else {
                Text("No data")
            }
            Button("Fetch Orders") {
              //  viewModel.fetchOrderList()
            }
        }
        .padding()
    }
}
