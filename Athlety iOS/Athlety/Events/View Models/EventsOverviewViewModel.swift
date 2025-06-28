//
//  EventsOverviewViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Combine
import Foundation

class EventsOverviewViewModel: ObservableObject {
    
    @Published var eventsByDate: [Date: [Event]] = [:]
    
    private let client: EventsClient = LadvEventsClient()
    
    func loadUpcomingEvents() async {
        let events = await client.loadUpcomingEvents()
        eventsByDate = Dictionary(grouping: events, by: { $0.date })
    }
}
