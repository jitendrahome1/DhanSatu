import SwiftUI

struct FooterView: View {
    let version: String
    let sebiNumber: String
    let message: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text("App Version : \(version)")
                .font(.footnote)
                .foregroundColor(.gray)
            Text("SEBI Number : \(sebiNumber)")
                .font(.footnote)
                .foregroundColor(.gray)
            Text(message)
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .padding(.top, 12)
    }
}
