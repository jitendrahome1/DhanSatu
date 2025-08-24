import SwiftUI

struct TabItem: Hashable, Equatable {
    let id = UUID()   // Unique ID for comparison
    let title: String
    let icon: String
    let view: AnyView

    static func == (lhs: TabItem, rhs: TabItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
