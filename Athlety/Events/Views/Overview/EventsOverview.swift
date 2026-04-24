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

    @EnvironmentObject private var overviewViewModel: EventsOverviewViewModel
    @EnvironmentObject private var filterViewModel: EventsFilterViewModel

    @State private var selectedCategory: EventsOverviewCategory = .upcoming

    @Query private var eventBookmarks: [EventBookmark]

    private var savedEvents: [Event] {
        eventBookmarks.map { $0.toEvent() }
    }

    private var hasActiveFilter: Bool {
        filterViewModel.associationId != nil || filterViewModel.discipline != nil
    }

    var body: some View {
        NavigationStack {
            EventsList(
                selectedCategory: $selectedCategory,
                upcomingEvents: overviewViewModel.upcomingEvents,
                savedEvents: savedEvents,
                onSaveAsBookmark: { overviewViewModel.saveEventAsBookmark($0, in: modelContext) },
                onRemoveFromBookmarks: { overviewViewModel.removeEventFromBookmarks($0, in: modelContext) }
            )
            .navigationTitle("Events")
            .toolbar {
                EventsToolbar(selectedCategory: selectedCategory, hasActiveFilter: hasActiveFilter)
            }
        }
        .task {
            await reloadEvents()
        }
        .onChange(of: filterViewModel.associationId) {
            Task { await reloadEvents() }
        }
        .onChange(of: filterViewModel.discipline) {
            Task { await reloadEvents() }
        }
    }

    private func reloadEvents() async {
        let associationId = filterViewModel.associationId
        let discipline = filterViewModel.discipline
        await overviewViewModel.loadUpcomingEvents(for: associationId, and: discipline)
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
