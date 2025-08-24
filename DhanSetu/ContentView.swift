import SwiftUI

struct OrderView: View {
    @StateObject private var viewModel = OrderViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Orders...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    List(viewModel.orders) { order in
                        OrderRow(order: order)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Dhan Orders")
            .onAppear {
                viewModel.fetchOrders()
            }
        }
    }
}

struct OrderRow: View {
    let order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(order.tradingSymbol)
                    .font(.headline)
                Spacer()
                Text(order.orderStatus)
                    .font(.subheadline)
                    .foregroundColor(order.orderStatus == "TRADED" ? .green : .orange)
            }
            HStack {
                Text("Qty: \(order.quantity)")
                Text("Price: \(String(format: "%.2f", order.price))")
                Text(order.transactionType)
                    .foregroundColor(order.transactionType == "BUY" ? .blue : .red)
            }
            .font(.caption)
            Text("Time: \(order.createTime)")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}
