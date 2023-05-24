//
//  EventsViewModel.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import SwiftUI

@MainActor
class EventsViewModel: ObservableObject {
    
    @Published var eventsByDate: [Date: [Event]] = [:]
    
    private let client: EventsClient = LadvEventsClient()
    
    func loadUpcomingEvents(for associationId: String?) async {
        let events = await client.loadUpcomingEvents(for: associationId)
        eventsByDate = Dictionary(grouping: events) { event in event.date }
    }
}
