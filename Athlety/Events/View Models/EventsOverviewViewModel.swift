//
//  EventsOverviewViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Foundation
import SwiftData

@Observable
final class EventsOverviewViewModel {
    private(set) var upcomingEvents: [Event] = []
    private(set) var associations: [Association] = []
    private(set) var isLoadingUpcomingEvents = false
    private(set) var passedEvents: [Event] = []
    private(set) var isLoadingPassedEvents = false
    /// The association the current `passedEvents` were loaded for, `nil` for all associations.
    private var passedEventsAssociationId: String?

    private let eventsClient: EventsClient = LadvEventsClient()
    private let associationsClient: AssociationsClient = LadvAssociationsClient()

    /// Loads the upcoming events matching `filter`.
    func loadUpcomingEvents(for filter: EventsFilter) async {
        isLoadingUpcomingEvents = true
        defer { isLoadingUpcomingEvents = false }

        let events = await eventsClient.loadUpcomingEvents(
            for: filter.associationId,
            and: filter.discipline,
            isWorldRankingsCompetition: filter.isWorldRankingsCompetition
        )

        guard !Task.isCancelled else { return }
        upcomingEvents = events
    }

    /// Loads the most recent passed events held in the association with `associationId`,
    /// unless they're already loaded for it.
    func loadPassedEvents(for associationId: String?) async {
        guard passedEvents.isEmpty || passedEventsAssociationId != associationId else { return }

        isLoadingPassedEvents = true
        defer { isLoadingPassedEvents = false }

        let events = await eventsClient.loadPassedEvents(for: associationId)

        guard !Task.isCancelled else { return }
        passedEvents = events
        passedEventsAssociationId = associationId
    }

    func loadAssociations() async {
        associations = await associationsClient.loadAssociations()
    }

    func association(withId associationId: String) -> Association? {
        associations.first(where: { $0.id == associationId })
    }

    func saveEventAsBookmark(_ event: Event, in context: ModelContext) {
        let bookmark = EventBookmark(event: event)
        context.insert(bookmark)
    }

    func removeEventFromBookmarks(_ event: Event, in context: ModelContext) {
        let eventId = event.id
        let predicate = #Predicate<EventBookmark> { $0.id == eventId }
        let fetchDescriptor = FetchDescriptor<EventBookmark>(predicate: predicate)
        guard let bookmark = try? context.fetch(fetchDescriptor).first else { return }
        context.delete(bookmark)
    }
}
