//
//  EventsOverviewViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Combine
import Foundation
import SwiftData

class EventsOverviewViewModel: ObservableObject {
    @Published private(set) var upcomingEvents: [Event] = []

    private let client: EventsClient = LadvEventsClient()

    func loadUpcomingEvents(for associationId: String?) async {
        upcomingEvents = await client.loadUpcomingEvents(for: associationId)
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
