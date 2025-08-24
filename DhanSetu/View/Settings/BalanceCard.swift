import SwiftUI

struct BalanceCard: View {
    let balance: String
    let onWithdraw: () -> Void
    let onAddFunds: () -> Void
    let onDisconnect: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Available to Trade")
                        .foregroundColor(.gray)
                    Text(balance)
                        .font(.title2)
                        .bold()
                }
                Spacer()
                Button(action: onDisconnect) {
                    Text("Disconnect")
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
            
            HStack(spacing: 12) {
                Button(action: onWithdraw) {
                    Text("Withdraw")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.green, lineWidth: 1)
                        )
                }
                
                Button(action: onAddFunds) {
                    Text("Add Funds")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
