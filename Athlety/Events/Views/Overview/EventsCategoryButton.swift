//
//  EventsCategoryButton.swift
//  Athlety
//
//  Created by Stefan Lipp on 25.08.25.
//

import SwiftUI

/// A single capsule in the events category selection.
struct EventsCategoryButton: View {
    let category: EventsOverviewCategory
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            HStack {
                Image(systemName: category.icon).symbolVariant(.fill)
                if isSelected {
                    Text(category.title)
                }
            }
            #if os(macOS)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(minWidth: 48, minHeight: 32)
            #else
            .padding(.horizontal)
            .padding(.vertical, 8)
            .frame(minWidth: 64, minHeight: 44)
            #endif
            .foregroundStyle(isSelected ? .white : .secondary)
            .background(isSelected ? Color.accentColor : Color(.tertiarySystemFill))
            .clipShape(.capsule)
            .contentShape(.capsule)
            .animation(.bouncy, value: isSelected)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(category.title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
