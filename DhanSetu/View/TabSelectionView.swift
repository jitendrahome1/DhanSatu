//
//  TabSelectionView.swift
//  DhanSetu
//
//  Created by Jitendra Agarwal on 24/06/25.
//

import SwiftUI
struct TabSelectionView: View {
    @Binding var selected: String
    let tabs = ["All", "Swing", "Medium Term"]

    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                Text(tab)
                    .fontWeight(.semibold)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(selected == tab ? Color.white.opacity(0.2) : .clear)
                    .cornerRadius(8)
                    .onTapGesture { selected = tab }
            }
        }
        .padding(.horizontal)
    }
}

