//
//  EventsCategorySelection.swift
//  Athlety
//
//  Created by Stefan Lipp on 25.08.25.
//

import SwiftUI

/// The row of capsules that switches between upcoming and saved events.
struct EventsCategorySelection: View {
    @Binding var selectedCategory: EventsOverviewCategory

    var body: some View {
        HStack(spacing: 12) {
            EventsCategoryButton(
                category: .upcoming,
                isSelected: selectedCategory == .upcoming,
                onSelect: { select(.upcoming) }
            )
            EventsCategoryButton(
                category: .saved,
                isSelected: selectedCategory == .saved,
                onSelect: { select(.saved) }
            )
        }
        .font(.headline)
        .listRowBackground(EmptyView())
        .listRowInsets(.leading, 0)
    }

    private func select(_ category: EventsOverviewCategory) {
        withAnimation(.bouncy) {
            selectedCategory = category
        }
    }
}

#Preview {
    @Previewable @State var selectedCategory: EventsOverviewCategory = .upcoming
    List {
        EventsCategorySelection(selectedCategory: $selectedCategory)
    }
}
