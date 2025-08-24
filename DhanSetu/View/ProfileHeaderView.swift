import SwiftUI

struct ProfileHeaderView: View {
    var body: some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 28))
                HStack(spacing: 4) {
                    Text("Premium")
                        .font(.caption2)
                        .padding(4)
                        .background(AppColors.buttonYellow)
                        .cornerRadius(4)
                        .foregroundColor(.black)
                    Text("Ayush Kumar")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            Spacer()
            HStack(spacing: 8) {
                Image(systemName: "d.circle.fill")
                    .foregroundColor(.green)
                Image(systemName: "eye.fill")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}
