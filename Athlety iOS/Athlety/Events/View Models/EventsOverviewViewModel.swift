//
//  EventsOverviewViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Combine
import Foundation

class EventsOverviewViewModel: ObservableObject {
    
    @Published private(set) var eventsByDate: [Date: [Event]] = [:]
    
    private let client: EventsClient = LadvEventsClient()
    
    func loadUpcomingEvents(for associationId: String?) async {
        let events = await client.loadUpcomingEvents(for: associationId)
        eventsByDate = Dictionary(grouping: events, by: { $0.date })
    }
}
