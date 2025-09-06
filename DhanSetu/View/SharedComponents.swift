import SwiftUI

// MARK: - Feature Icons Grid
struct FeatureIconsGrid: View {
    let features = [
        ("square.grid.2x2", "Sector", Color.green),
        ("square.stack.3d.up", "Heatmap", Color.red),
        ("chart.line.uptrend.xyaxis", "Live News", Color.green),
        ("heart", "Watchlist", Color.primary)
    ]
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(Array(features.enumerated()), id: \.offset) { index, feature in
                VStack(spacing: 8) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .frame(width: 60, height: 60)
                        .overlay {
                            Image(systemName: feature.0)
                                .font(.title2)
                                .foregroundColor(feature.2)
                        }
                    
                    Text(feature.1)
                        .font(.caption)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

// MARK: - AI-Powered Signals Card
struct AIPoweredSignalsCard: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("AI-Powered Signals")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "sparkles")
                            .foregroundColor(.green)
                            .font(.caption)
                        
                        Text("AI Generated")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green)
                            .cornerRadius(4)
                    }
                }
                
                Text("Accurate, fast, and auto-generated for you")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Button(action: {}) {
                    Text("Explore")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.green)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .cornerRadius(20)
                }
                .padding(.top, 8)
            }
            
            Spacer()
            
            // Chart placeholder
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray5))
                    .frame(width: 100, height: 80)
                    .overlay {
                        VStack(spacing: 4) {
                            Text("RELIANCE")
                                .font(.caption2)
                                .foregroundColor(.white)
                            Text("Entry")
                                .font(.caption2)
                                .foregroundColor(.red)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.red)
                                .cornerRadius(4)
                        }
                    }
            }
        }
        .padding(20)
        .background(Color.black)
        .cornerRadius(12)
    }
}

// MARK: - Equity/F&O Tabs
struct EquityFOTabs: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack(spacing: 0) {
            // Equity Tab
            Button(action: { selectedTab = "Equity" }) {
                HStack(spacing: 8) {
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(.white)
                    Text("Equity")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.black)
                .cornerRadius(8)
            }
            
            // F&O Tab
            Button(action: { selectedTab = "F&O" }) {
                HStack(spacing: 8) {
                    Image(systemName: "chart.line.uptrend.xyaxis")
                        .foregroundColor(.primary)
                    Text("F&O")
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
        }
        .padding(4)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Live Signals Section
struct LiveSignalsSection: View {
    @Binding var selectedTab: String
    @Binding var selectedFilter: String
    
    var body: some View {
        VStack(spacing: 16) {
            // Section Header
            HStack {
                HStack(spacing: 8) {
                    Text("Live Signals")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Image(systemName: "info.circle")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                Spacer()
                
                Text("View all")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            
            // All Trades / My Trades Tabs
            HStack(spacing: 0) {
                Button(action: { selectedTab = "All Trades" }) {
                    Text("All Trades")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(selectedTab == "All Trades" ? .green : .gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            selectedTab == "All Trades" ? 
                            Color.clear : Color.clear
                        )
                        .overlay(
                            selectedTab == "All Trades" ?
                            Rectangle()
                                .fill(Color.green)
                                .frame(height: 2)
                                .offset(y: 20) : nil
                        )
                }
                
                Button(action: { selectedTab = "My Trades" }) {
                    Text("My Trades")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(selectedTab == "My Trades" ? .green : .gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(
                            selectedTab == "My Trades" ? 
                            Color.clear : Color.clear
                        )
                        .overlay(
                            selectedTab == "My Trades" ?
                            Rectangle()
                                .fill(Color.green)
                                .frame(height: 2)
                                .offset(y: 20) : nil
                        )
                }
            }
            
            // Filter Chips
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    FilterChip(title: "All", isSelected: selectedFilter == "All") {
                        selectedFilter = "All"
                    }
                    
                    FilterChip(title: "AI Generated Signals", isSelected: selectedFilter == "AI Generated Signals") {
                        selectedFilter = "AI Generated Signals"
                    }
                    
                    FilterChip(title: "Analyst Signals", isSelected: selectedFilter == "Analyst Signals") {
                        selectedFilter = "Analyst Signals"
                    }
                }
                .padding(.horizontal, 4)
            }
        }
    }
}

// MARK: - Filter Chip
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if title == "AI Generated Signals" {
                    Image(systemName: "sparkles")
                        .font(.caption)
                } else if title == "Analyst Signals" {
                    Image(systemName: "person.2.fill")
                        .font(.caption)
                }
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color.black : Color(.systemGray6))
            .cornerRadius(20)
        }
    }
}

// MARK: - Stock Signal Card (Dynamic version for Home)
struct StockSignalCard: View {
    let stockSignal: StockSignal
    var body: some View {
        VStack(spacing: 0) {
            // Top tags
            HStack {
                Text("Swing Long")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.orange)
                    .cornerRadius(4)
                Spacer()
                Text("Stock Options")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .cornerRadius(4)
                Text("Call")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green)
                    .cornerRadius(4)
            }
            .padding(8)
            // Stock Info
            HStack(spacing: 12) {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 40, height: 40)
                    .overlay {
                        Text(stockSignal.stockName.prefix(1))
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                VStack(alignment: .leading, spacing: 4) {
                    Text(stockSignal.stockName)
                        .font(.headline)
                        .fontWeight(.semibold)
                    HStack {
                        Image(systemName: "building.2")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("NSE")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("₹\(stockSignal.formattedCurrentPrice)")
                        .font(.headline)
                        .fontWeight(.semibold)
                    HStack(spacing: 4) {
                        Text("+₹3.35")
                            .foregroundColor(.green)
                        Text(stockSignal.formattedProfitPercent)
                            .foregroundColor(.green)
                    }
                    .font(.caption)
                }
            }
            .padding(8)
            // Live
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
            .padding(8)
            // Progress
            HStack {
                Text("SL")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Rectangle()
                    .fill(Color.red)
                    .frame(height: 4)
                    .frame(maxWidth: .infinity)
                VStack(spacing: 4) {
                    Text("Entry")
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Text(stockSignal.formattedEntryDate)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                Rectangle()
                    .fill(Color.green)
                    .frame(height: 4)
                    .frame(maxWidth: .infinity)
                Text("Target")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .padding(8)
            // Strategy and Status
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Strategy")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Momentum Edge")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Status")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(stockSignal.status)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.green)
                }
            }
            .padding(8)
            // Price details
            HStack(spacing: 0) {
                VStack(spacing: 4) {
                    Text("Entry")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("₹45.50")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                VStack(spacing: 4) {
                    Text("Stop Loss")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("₹\(stockSignal.formattedStopLoss)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                VStack(spacing: 4) {
                    Text("Target")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("₹\(stockSignal.formattedTarget)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(8)
            // Trade Now
            Button(action: {}) {
                Text("Trade Now")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(Color.green)
                    .cornerRadius(12)
            }
            .padding(8)
        }
        .frame(width: 350)
        .background(Color.white)
        .cornerRadius(12)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.2), lineWidth: 1))
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

//#Preview {
//    ScrollView {
//        VStack(spacing: 16) {
//            FeatureIconsGrid()
//            AIPoweredSignalsCard()
//            EquityFOTabs(selectedTab: .constant("Equity"))
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 16) {
//                    ForEach(signalViewModel.stockSignals) { stockSignal in
//                        StockSignalCard(stockSignal: stockSignal)
//                    }
//                }
//                .padding(.horizontal, 16)
//            }
//        }
//        .padding()
//    }
//}
