import SwiftUI

struct EnhancedStockSignalCard: View {
    var body: some View {
        VStack(spacing: 0) {
            // Header with tags
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(.white)
                        .font(.caption)
                    
                    Text("Analyst Signal")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.brown)
                .cornerRadius(4)
                
                Spacer()
                
                HStack(spacing: 8) {
                    Text("Swing")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.orange)
                        .cornerRadius(4)
                    
                    Text("Equity")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue)
                        .cornerRadius(4)
                }
            }
            .padding(16)
            .background(Color.white)
            
            // Stock Info Section
            HStack(spacing: 12) {
                // Company Logo
                Circle()
                    .fill(Color.orange)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Text("M")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("MEDANTA")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "building.2")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Text("NSE")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Text("Global Health Limited")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("₹1,400.10")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    HStack(spacing: 4) {
                        Text("+₹3.80")
                            .foregroundColor(.green)
                        Text("(+0.27%)")
                            .foregroundColor(.green)
                    }
                    .font(.caption)
                }
            }
            .padding(16)
            .background(Color.white)
            
            // Live indicator section
            HStack {
                Text("Live")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.red)
                    .cornerRadius(4)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.white)
            
            // Progress Chart Section
            VStack(spacing: 8) {
                HStack {
                    VStack {
                        Text("SL")
                            .font(.caption2)
                            .foregroundColor(.gray)
                        Circle()
                            .fill(Color.black)
                            .frame(width: 12, height: 12)
                    }
                    
                    Rectangle()
                        .fill(Color.red)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text("Entry")
                            .font(.caption2)
                            .foregroundColor(.gray)
                        Circle()
                            .fill(Color.red)
                            .frame(width: 12, height: 12)
                    }
                    
                    Rectangle()
                        .fill(Color.green)
                        .frame(height: 4)
                        .frame(maxWidth: .infinity)
                    
                    VStack {
                        Text("Target")
                            .font(.caption2)
                            .foregroundColor(.gray)
                        Circle()
                            .fill(Color.black)
                            .frame(width: 12, height: 12)
                    }
                }
                
                VStack(spacing: 2) {
                    Text("25 Aug")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text("12:41 PM")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            .padding(16)
            .background(Color.white)
            
            // Potential Profit Section
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Potential Profit")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("+12.00%")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Status")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("In Buying Range")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.green)
                }
            }
            .padding(16)
            .background(Color(.systemGray6).opacity(0.3))
            
            // Price Details Section
            HStack(spacing: 0) {
                VStack(spacing: 4) {
                    Text("Entry")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("₹1,398.90")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                
                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(width: 1, height: 40)
                
                VStack(spacing: 4) {
                    Text("Stop Loss")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("₹1,349.55")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                
                Rectangle()
                    .fill(Color(.systemGray4))
                    .frame(width: 1, height: 40)
                
                VStack(spacing: 4) {
                    Text("Target")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("₹1,566.32")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(16)
            .background(Color.white)
            
            // Trade Now Button
            Button(action: {
                print("Trade Now tapped")
            }) {
                Text("Trade Now")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.green)
                    .cornerRadius(12)
            }
            .padding(16)
            .background(Color.white)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    EnhancedStockSignalCard()
        .padding()
}
