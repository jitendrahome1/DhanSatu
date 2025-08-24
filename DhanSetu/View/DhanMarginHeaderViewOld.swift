//import SwiftUI
//
//struct DhanMarginHeaderViewOld: View {
//    @StateObject private var viewModel = FundLimitsViewModel()
//
//    var body: some View {
//        HStack {
//            HStack(spacing: 8) {
//                Image(systemName: "d.circle.fill")
//                    .foregroundColor(.green)
//                    .font(.system(size: 22))
//                Text("Dhan")
//                    .font(.headline)
//                    .foregroundColor(.white)
//            }
//            Spacer()
//            VStack(alignment: .trailing, spacing: 2) {
//                HStack(spacing: 4) {
//                    Text("Margin Available")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                    Image(systemName: "eye.fill")
//                        .foregroundColor(.gray)
//                        .font(.caption)
//                }
//                if let balance = viewModel.availableBalance {
//                    Text("₹\(String(format: "%.2f", balance))")
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                } else if viewModel.isLoading {
//                    ProgressView()
//                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
//                } else if let error = viewModel.errorMessage {
//                    Text(error)
//                        .foregroundColor(.red)
//                        .font(.caption)
//                } else {
//                    Text("—")
//                        .foregroundColor(.white)
//                }
//            }
//        }
//        .padding()
//        .background(
//            RoundedRectangle(cornerRadius: 12)
//                .stroke(Color.green, lineWidth: 1.2)
//                .background(Color.black.opacity(0.3).cornerRadius(12))
//        )
//        .padding(.horizontal)
//        .onAppear {
//           // viewModel.startAutoRefresh(interval: AppConstants.RefreshInterval) // refresh every 10 seconds
//        }
//        .onDisappear {
//           // viewModel.stopAutoRefresh()
//        }
//    }
//}
