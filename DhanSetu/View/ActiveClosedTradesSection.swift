import SwiftUI

struct ActiveClosedTradesSection: View {
    @Binding var selectedTab: String
    
    var body: some View {
        VStack(spacing: 16) {
            // Trades Tabs
            HStack(spacing: 0) {
                Button(action: { selectedTab = "Active Trades" }) {
                    VStack(spacing: 8) {
                        Text("Active Trades")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(selectedTab == "Active Trades" ? .green : .gray)
                        
                        if selectedTab == "Active Trades" {
                            Rectangle()
                                .fill(Color.green)
                                .frame(height: 3)
                                .cornerRadius(1.5)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Button(action: { selectedTab = "Closed Trades" }) {
                    VStack(spacing: 8) {
                        Text("Closed Trades")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(selectedTab == "Closed Trades" ? .green : .gray)
                        
                        if selectedTab == "Closed Trades" {
                            Rectangle()
                                .fill(Color.green)
                                .frame(height: 3)
                                .cornerRadius(1.5)
                        } else {
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 3)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Info icon for both sections
                HStack {
                    Spacer()
                    Image(systemName: "info.circle")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(width: 30)
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ActiveClosedTradesSection(selectedTab: .constant("Active Trades"))
        .padding()
}
