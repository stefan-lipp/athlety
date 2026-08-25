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

    @Environment(EventsOverviewViewModel.self) private var viewModel

    @AppStorage("eventsFilterAssociationId") private var filterAssociationId: String?
    @AppStorage("eventsFilterDiscipline") private var filterDiscipline: Discipline?

    @State private var selectedCategory: EventsOverviewCategory = .upcoming

    @Query private var eventBookmarks: [EventBookmark]

    private var savedEvents: [Event] {
        eventBookmarks.map { $0.toEvent() }
    }

    private var filter: EventsFilter {
        EventsFilter(associationId: filterAssociationId, discipline: filterDiscipline)
    }

    var body: some View {
        NavigationStack {
            EventsList(
                selectedCategory: $selectedCategory,
                upcomingEvents: viewModel.upcomingEvents,
                savedEvents: savedEvents,
                isLoadingUpcomingEvents: viewModel.isLoadingUpcomingEvents,
                onSaveAsBookmark: { viewModel.saveEventAsBookmark($0, in: modelContext) },
                onRemoveFromBookmarks: { viewModel.removeEventFromBookmarks($0, in: modelContext) }
            )
            .navigationTitle("Events")
            .toolbar {
                EventsToolbar(selectedCategory: selectedCategory, hasActiveFilter: filter.isActive)
            }
        }
        .task(id: filter) {
            await viewModel.loadUpcomingEvents(for: filter)
        }
    }
}

#Preview {
    EventsOverview()
        .environment(EventsOverviewViewModel())
        .environment(CalendarEventViewModel())
}
