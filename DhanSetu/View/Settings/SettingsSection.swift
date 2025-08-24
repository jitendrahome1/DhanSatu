import SwiftUI

struct SettingsSection: View {
    let title: String
    let rows: [SettingsRowModel]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .padding([.top, .horizontal])
            
            ForEach(rows) { row in
                SettingsRow(title: row.title, icon: row.icon)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
