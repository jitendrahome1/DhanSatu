import SwiftUI

struct SignalCardPreview: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header with stock name and price
            HStack {
                Text("MEDANTA")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.orange)
                    .font(.caption)
                
                Text("NSE")
                    .font(.caption2)
                    .foregroundColor(.gray)
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("₹1,400.10")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("+₹3.80 (+0.27%)")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
            
            Text("Global Health Limited")
                .font(.caption)
                .foregroundColor(.gray)
            
            // Status indicator
            HStack {
                Text("Live")
                    .font(.caption2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                
                Spacer()
            }
            
            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 4)
                    
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: geometry.size.width * 0.7, height: 4)
                }
                .cornerRadius(2)
            }
            .frame(height: 4)
            .padding(.vertical, 8)
            
            // Tags
            HStack {
                Text("Swing")
                    .font(.caption2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                
                Text("Equity")
                    .font(.caption2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(4)
                
                Spacer()
            }
        }
        .padding()
        .background(
            AppColors.cardBackground
                .cornerRadius(12)
                .overlay(
                    AnimatedGradientBorder()
                )
        )
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        SignalCardPreview()
    }
}