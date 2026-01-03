//
//  EventsToolbar.swift
//  Athlety
//
//  Created by Stefan Lipp on 03.01.26.
//

import SwiftUI

struct EventsToolbar: ToolbarContent {
    
    let selectedCategory: EventsOverviewCategory
    let hasActiveFilter: Bool
    
    @State private var showFilter = false
    @State private var showSettings = false
    
    var body: some ToolbarContent {
        filterButton
        ToolbarSpacer()
        settingsButton
    }
    
    @ToolbarContentBuilder
    private var filterButton: some ToolbarContent {
        ToolbarItem {
            let hasActiveFilter = Binding<Bool> {
                self.hasActiveFilter
            } set: { _ in
                showFilter = true
            }
            if selectedCategory == .upcoming {
                Toggle(isOn: hasActiveFilter) {
                    Label("Filter", systemImage: "line.3.horizontal.decrease")
                }
                .sheet(isPresented: $showFilter) {
                    EventsFilterView()
                }
            }
        }
    }
    
    @ToolbarContentBuilder
    private var settingsButton: some ToolbarContent {
        ToolbarItem {
            Button {
                showSettings = true
            } label: {
                Label("Settings", systemImage: "person")
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }
}
