//
//  EventsFilterRow.swift
//  Athlety
//
//  Created by Stefan Lipp on 29.06.25.
//

import SwiftUI

struct EventsFilterRow: View {
    let name: LocalizedStringKey
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button {
            onSelect()
        } label: {
            HStack {
                Text(name)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.accent)
                        .fontWeight(.bold)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
