//
//  EventsOverview.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftData
import SwiftUI

struct EventsOverview: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject private var eventsOverviewViewModel: EventsOverviewViewModel
    @EnvironmentObject private var eventsFilterViewModel: EventsFilterViewModel
    
    @State private var selectedCategory: EventsOverviewCategory = .upcoming
    
    @Query private var eventBookmarks: [EventBookmark]
    
    private var savedEvents: [Event] {
        eventBookmarks.map { $0.toEvent() }
    }
    
    var body: some View {
        NavigationStack {
            EventsList(
                selectedCategory: $selectedCategory,
                upcomingEvents: eventsOverviewViewModel.upcomingEvents,
                savedEvents: savedEvents,
                onSaveAsBookmark: { eventsOverviewViewModel.saveEventAsBookmark($0, in: modelContext) },
                onRemoveFromBookmarks: { eventsOverviewViewModel.removeEventFromBookmarks($0, in: modelContext) }
            )
            .navigationTitle("Events")
            .toolbar {
                let hasActiveFilter = eventsFilterViewModel.eventsFilterAssociationId != nil
                EventsToolbar(selectedCategory: selectedCategory, hasActiveFilter: hasActiveFilter)
            }
        }
        .task {
            await reloadEvents()
        }
        .onChange(of: eventsFilterViewModel.eventsFilterAssociationId) {
            Task { await reloadEvents() }
        }
        .onChange(of: eventsFilterViewModel.eventsFilterDiscipline) {
            Task { await reloadEvents() }
        }
    }
    
    private func reloadEvents() async {
        let associationId = eventsFilterViewModel.eventsFilterAssociationId
        let discipline = eventsFilterViewModel.eventsFilterDiscipline
        await eventsOverviewViewModel.loadUpcomingEvents(for: associationId, and: discipline)
    }
}

enum EventsOverviewCategory {
    case upcoming
    case saved

    var icon: String {
        self == .upcoming ? "square.stack" : "bookmark"
    }

    var title: LocalizedStringKey {
        self == .upcoming ? "Upcoming" : "Saved"
    }
}

#Preview {
    EventsOverview()
        .environmentObject(EventsOverviewViewModel())
        .environmentObject(EventsFilterViewModel())
        .environmentObject(SettingsStore())
}
