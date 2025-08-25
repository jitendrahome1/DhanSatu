import SwiftUI

struct OTPBoxesView: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    private let length: Int = 6

    var body: some View {
        ZStack {
            // Visual boxes
            HStack(spacing: 10) {
                ForEach(0..<length, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(.quaternary)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(.secondarySystemBackground))
                            )
                            .frame(height: 54)

                        Text(character(at: index))
                            .font(.title2.weight(.semibold))
                            .monospacedDigit()
                    }
                }
            }

            // Invisible TextField for input
            TextField("", text: Binding(
                get: { String(text.prefix(length)).filter { $0.isNumber } },
                set: { new in
                    let filtered = new.filter { $0.isNumber }
                    text = String(filtered.prefix(length))
                }
            ))
            .keyboardType(.numberPad)
            .textContentType(.oneTimeCode)
            .focused($isFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .tint(.clear)
            .foregroundStyle(.clear)
            .frame(width: 0, height: 0)
            .onAppear { DispatchQueue.main.async { isFocused = true } }
        }
        .contentShape(Rectangle())
        .onTapGesture { isFocused = true }
    }

    private func character(at index: Int) -> String {
        let chars = Array(text)
        if index < chars.count { return String(chars[index]) }
        return "\u{00A0}" // Non-breaking space for empty boxes
    }
}
