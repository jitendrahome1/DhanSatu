import SwiftUI

struct StockSignalsListView: View {
    @StateObject private var viewModel = StockSignalViewModel()
    @State private var showingCreateSheet = false
    @State private var showingNotification = false
    @State private var notificationMessage = ""
    @State private var notificationType: NotificationView.NotificationType = .success
    
    var body: some View {
        ZStack {
            // Background
            AppColors.cardBackground
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView("Loading signals...")
                    .foregroundColor(.white)
            } else if let errorMessage = viewModel.errorMessage {
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text("Error")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Button("Retry") {
                        viewModel.refreshSignals()
                    }
                    .foregroundColor(.blue)
                    .padding()
                }
            } else if viewModel.stockSignals.isEmpty {
                VStack {
                    Image(systemName: "chart.bar.doc.horizontal")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    Text("No Signals Available")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Create your first stock signal to get started")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                                        } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.stockSignals) { signal in
                            StockSignalCardView(stockSignal: signal)
                                .contextMenu {
                                    Button("Delete", role: .destructive) {
                                        deleteSignal(signal)
                                    }
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .refreshable {
                    await refreshSignals()
                }
            }
        }
        .onAppear {
            if viewModel.stockSignals.isEmpty {
                viewModel.fetchStockSignals()
            }
        }
        .overlay(
            VStack {
                if showingNotification {
                    NotificationView(
                        message: notificationMessage,
                        type: notificationType,
                        isShowing: $showingNotification
                    )
                    .animation(.easeInOut(duration: 0.3), value: showingNotification)
                }
                Spacer()
            }
        )
    }
    
    private func deleteSignal(_ signal: StockSignal) {
        viewModel.deleteStockSignal(id: signal.id) { success in
            if success {
                // Signal deleted successfully, list will be refreshed automatically
                showNotification("Signal deleted successfully", type: .success)
            } else {
                // Error handling is done in the viewModel
                showNotification("Failed to delete signal", type: .error)
            }
        }
    }
    
    private func showNotification(_ message: String, type: NotificationView.NotificationType) {
        notificationMessage = message
        notificationType = type
        withAnimation(.easeInOut(duration: 0.3)) {
            showingNotification = true
        }
    }
    
    private func refreshSignals() async {
        await withCheckedContinuation { continuation in
            viewModel.fetchStockSignals()
            // Add a small delay to ensure the fetch completes
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                continuation.resume()
            }
        }
    }
}

// removed filter UI helpers

#Preview {
    StockSignalsListView()
}
