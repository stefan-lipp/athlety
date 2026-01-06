//
//  ListSectionHeader.swift
//  Athlety
//
//  Created by Stefan Lipp on 06.01.26.
//

import SwiftUI

struct ListSectionHeader: View {
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .fontWeight(.medium)
            .font(.title2)
            .padding(.top)
            .listRowSeparator(.hidden)
    }
}

#Preview {
    ListSectionHeader(title: "Recommend")
}
