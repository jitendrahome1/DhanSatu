import SwiftUI

struct ProfileCard: View {
    let name: String
    let email: String
    let phone: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name).font(.headline)
                Text(email).font(.subheadline).foregroundColor(.gray)
                Text(phone).font(.subheadline).foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "crown.fill")
                .foregroundColor(.yellow)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
