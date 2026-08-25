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

    private let eventsClient: EventsClient = LadvEventsClient()
    private let associationsClient: AssociationsClient = LadvAssociationsClient()

    /// Loads the upcoming events matching `filter`.
    func loadUpcomingEvents(for filter: EventsFilter) async {
        isLoadingUpcomingEvents = true
        let events = await eventsClient.loadUpcomingEvents(for: filter.associationId, and: filter.discipline)
        
        guard !Task.isCancelled else { return }
        upcomingEvents = events
        isLoadingUpcomingEvents = false
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
