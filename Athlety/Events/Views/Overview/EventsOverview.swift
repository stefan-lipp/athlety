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
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @Environment(EventsOverviewViewModel.self) private var viewModel

    @AppStorage("eventsFilterAssociationId") private var filterAssociationId: String?
    @AppStorage("eventsFilterDiscipline") private var filterDiscipline: Discipline?
    @AppStorage("eventsFilterWorldRankingsCompetition") private var filterIsWorldRankingsCompetition = false

    @State private var selectedCategory: EventsOverviewCategory = .upcoming
    @State private var selectedEventId: Int?

    @Query private var eventBookmarks: [EventBookmark]

    private var savedEvents: [Event] {
        eventBookmarks.map { $0.toEvent() }
    }

    private var filter: EventsFilter {
        EventsFilter(
            associationId: filterAssociationId,
            discipline: filterDiscipline,
            isWorldRankingsCompetition: filterIsWorldRankingsCompetition
        )
    }

    var body: some View {
        NavigationSplitView {
            EventsList(
                selectedCategory: $selectedCategory,
                selectedEventId: $selectedEventId,
                upcomingEvents: viewModel.upcomingEvents,
                savedEvents: savedEvents,
                isLoadingUpcomingEvents: viewModel.isLoadingUpcomingEvents,
                onSaveAsBookmark: { viewModel.saveEventAsBookmark($0, in: modelContext) },
                onRemoveFromBookmarks: { viewModel.removeEventFromBookmarks($0, in: modelContext) }
            )
            .navigationTitle("Events")
            .toolbar {
                EventsListToolbar(
                    selectedCategory: selectedCategory,
                    hasActiveFilter: filter.isActive,
                    showSettingsButton: horizontalSizeClass == .compact
                )
            }
        } detail: {
            NavigationStack {
                if let selectedEventId {
                    EventDetailsView(eventId: selectedEventId)
                } else {
                    EventsPlaceholderView(
                        icon: "calendar",
                        title: "Select an Event",
                        description: "Choose an event from the list to see its details."
                    )
                }
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
