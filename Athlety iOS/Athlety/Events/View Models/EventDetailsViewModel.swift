//
//  EventDetailsViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 11.07.25.
//

import Combine

class EventDetailsViewModel: ObservableObject {
    
    @Published var event: EventDetails?
    
    private let client: EventsClient = LadvEventsClient()
    
    func loadEventDetails(for eventId: Int) async {
        event = await client.loadEventDetails(for: eventId)
    }
}
