import SwiftUI

struct BannerCard: View {
    let title: String
    let message: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "person.fill.checkmark")
                    .foregroundColor(.white)
                Text(title)
                    .foregroundColor(.white)
                    .bold()
                Spacer()
            }
            Text(message)
                .foregroundColor(.white)
                .font(.footnote)
        }
        .padding()
        .background(Color.green)
        .cornerRadius(12)
    }
}
