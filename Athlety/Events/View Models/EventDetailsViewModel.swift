//
//  EventDetailsViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 11.07.25.
//

import Combine
import Foundation
import SwiftData

class EventDetailsViewModel: ObservableObject {
    
    @Published private(set) var event: EventDetails?
    @Published private(set) var isSavedAsBookmark = false
    
    private let client: EventsClient = LadvEventsClient()
    
    func loadEventDetails(for eventId: Int, with context: ModelContext) async {
        event = await client.loadEventDetails(for: eventId)
        let eventBookmark = findEventBookmark(for: eventId, in: context)
        isSavedAsBookmark = eventBookmark != nil
    }
    
    func resetEventDetails() {
        event = nil
        isSavedAsBookmark = false
    }
    
    func saveEventAsBookmark(in context: ModelContext) {
        guard let event else { return }
        let bookmark = EventBookmark(event: event)
        context.insert(bookmark)
        isSavedAsBookmark = true
    }

    func removeEventFromBookmarks(in context: ModelContext) {
        guard let event else { return }
        guard let bookmark = findEventBookmark(for: event.id, in: context) else { return }
        context.delete(bookmark)
        isSavedAsBookmark = false
    }
    
    private func findEventBookmark(for eventId: Int, in context: ModelContext) -> EventBookmark? {
        let predicate = #Predicate<EventBookmark> { $0.id == eventId }
        let fetchDescriptor = FetchDescriptor<EventBookmark>(predicate: predicate)
        return try? context.fetch(fetchDescriptor).first
    }
}
