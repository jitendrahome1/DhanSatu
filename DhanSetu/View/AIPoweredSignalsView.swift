import SwiftUI

struct AIPoweredSignalsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("AI-Powered Signals")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                    Text("AI Generated")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
            
            Text("Accurate, fast, and auto-generated for you")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Button(action: {
                print("Explore tapped")
            }) {
                Text("Explore")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color.green)
                    .cornerRadius(20)
            }
            
            // Signal preview image
            ZStack(alignment: .topTrailing) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .foregroundColor(.green)
                    .padding()
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(12)
                
                VStack(alignment: .trailing) {
                    Text("RELIANCE")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("BUY")
                        .font(.caption2)
                        .padding(4)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                }
                .padding(8)
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
        AIPoweredSignalsView()
    }
}
