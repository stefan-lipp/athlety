//
//  EventsCategorySelection.swift
//  Athlety
//
//  Created by Stefan Lipp on 25.08.25.
//

import SwiftUI

/// The row of capsules that switches between upcoming, passed, and saved events.
struct EventsCategorySelection: View {
    @Binding var selectedCategory: EventsOverviewCategory

    var body: some View {
        HStack(spacing: 12) {
            ForEach([EventsOverviewCategory.upcoming, .passed, .saved], id: \.self) { category in
                EventsCategoryButton(
                    category: category,
                    isSelected: selectedCategory == category,
                    onSelect: { select(category) }
                )
            }
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
