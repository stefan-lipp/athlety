//
//  EventsOverviewViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Combine

class EventsOverviewViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    
    private let client: EventsClient = LadvEventsClient()
    
    func loadUpcomingEvents() async {
        events = await client.loadUpcomingEvents()
    }
}
