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

    /// The association to load past events for, or `nil` while the past category isn't
    /// selected, so they're only fetched once someone looks at them.
    private var pastEventsAssociationId: String?? {
        selectedCategory == .past ? .some(filterAssociationId) : nil
    }

    var body: some View {
        NavigationSplitView {
            EventsList(
                selectedCategory: $selectedCategory,
                selectedEventId: $selectedEventId,
                upcomingEvents: viewModel.upcomingEvents,
                pastEvents: viewModel.pastEvents,
                savedEvents: savedEvents,
                isLoadingUpcomingEvents: viewModel.isLoadingUpcomingEvents,
                isLoadingPastEvents: viewModel.isLoadingPastEvents,
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
        .task(id: pastEventsAssociationId) {
            guard case let .some(associationId) = pastEventsAssociationId else { return }
            await viewModel.loadPastEvents(for: associationId)
        }
        .onChange(of: eventBookmarks.isEmpty, initial: true) { _, isEmpty in
            BookmarkTip.hasBookmarks = !isEmpty
        }
    }
}

#Preview {
    EventsOverview()
        .environment(EventsOverviewViewModel())
        .environment(CalendarEventViewModel())
}
