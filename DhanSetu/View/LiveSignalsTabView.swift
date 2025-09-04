import SwiftUI

struct LiveSignalsTabView: View {
    @State private var selectedTab = "All Trades"
    @State private var selectedFilter = "All"
    
    let tabs = ["All Trades", "My Trades"]
    let filters = ["All", "AI Generated Signals", "Analyst Signals"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Live Signals")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Image(systemName: "info.circle")
                    .foregroundColor(.gray)
                
                Spacer()
                
                Button(action: {
                    print("View all tapped")
                }) {
                    Text("View all")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            // Tabs
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { tab in
                    Button(action: {
                        selectedTab = tab
                    }) {
                        Text(tab)
                            .font(.subheadline)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .foregroundColor(selectedTab == tab ? .white : .gray)
                    }
                    .background(
                        VStack {
                            Spacer()
                            if selectedTab == tab {
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(height: 2)
                            } else {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 1)
                            }
                        }
                    )
                    .frame(maxWidth: .infinity)
                }
            }
            
            // Filters
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(filters, id: \.self) { filter in
                        Button(action: {
                            selectedFilter = filter
                        }) {
                            HStack(spacing: 4) {
                                if filter == "AI Generated Signals" {
                                    Image(systemName: "cpu")
                                        .font(.caption)
                                } else if filter == "Analyst Signals" {
                                    Image(systemName: "person.fill")
                                        .font(.caption)
                                }
                                
                                Text(filter)
                                    .font(.caption)
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(selectedFilter == filter ? Color.green : Color.white.opacity(0.1))
                            .foregroundColor(selectedFilter == filter ? .black : .white)
                            .cornerRadius(20)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        LiveSignalsTabView()
    }
}