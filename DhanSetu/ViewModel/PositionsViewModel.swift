// PositionsViewModel.swift

import Foundation

@MainActor
class PositionsViewModel: ObservableObject {
    @Published var positions: [PositionResponse] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let api = DhanHQManager.shared

    func getPositions() async {
        isLoading = true
        errorMessage = nil
        do {
            let response = try await api.getPositionsAsync()
            self.positions = response
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
