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
    
    func loadUpcomingEvents() async {
        let events = await client.loadUpcomingEvents()
        eventsByDate = Dictionary(grouping: events) { event in event.date }
    }
}
