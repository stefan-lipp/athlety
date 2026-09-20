//
//  EventsListToolbar.swift
//  Athlety
//
//  Created by Stefan Lipp on 03.01.26.
//

import SwiftUI

struct EventsListToolbar: ToolbarContent {
    @Environment(\.colorScheme) private var colorScheme

    let selectedCategory: EventsOverviewCategory
    let hasActiveFilter: Bool
    let showSettingsButton: Bool

    @State private var showFilter = false

    var body: some ToolbarContent {
        filterButton
        if showSettingsButton {
            ToolbarSpacer()
            SettingsToolbarButton()
        }
    }

    @ToolbarContentBuilder
    private var filterButton: some ToolbarContent {
        ToolbarItem {
            if selectedCategory == .upcoming {
                Toggle(isOn: Binding { hasActiveFilter } set: { _ in showFilter = true }) {
                    Label("Filter", systemImage: "line.3.horizontal.decrease")
                }
                .sheet(isPresented: $showFilter) {
                    EventsFilterView()
                        .preferredColorScheme(colorScheme)
                }
            }
        }
    }
}
