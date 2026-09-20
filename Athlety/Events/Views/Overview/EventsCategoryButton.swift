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
            .padding(.horizontal)
            .padding(.vertical, 8)
            .frame(minWidth: 64, minHeight: 44)
            .foregroundStyle(isSelected ? .white : .secondary)
            .background(isSelected ? Color.accentColor : Color(.tertiarySystemFill))
            .clipShape(Capsule())
            .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(category.title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}
