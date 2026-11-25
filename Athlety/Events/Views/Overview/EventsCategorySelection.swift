//
//  EventsCategorySelection.swift
//  Athlety
//
//  Created by Stefan Lipp on 25.08.25.
//

import SwiftUI

/// The row of capsules that switches between upcoming, past, and saved events.
struct EventsCategorySelection: View {
    @Binding var selectedCategory: EventsOverviewCategory

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                categoryButtons
            }
            .scrollIndicators(.never)
            .scrollClipDisabled()
            .onChange(of: selectedCategory) { _, category in
                withAnimation(.bouncy) {
                    proxy.scrollTo(category)
                }
            }
        }
        .font(.headline)
        .listRowBackground(EmptyView())
        .listRowInsets(.horizontal, 0)
    }

    private var categoryButtons: some View {
        HStack(spacing: 12) {
            ForEach(EventsOverviewCategory.allCases, id: \.self) { category in
                EventsCategoryButton(
                    category: category,
                    isSelected: selectedCategory == category,
                    onSelect: { select(category) }
                )
                .id(category)
            }
        }
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
