//
//  EventsViewModel.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import SwiftUI

@MainActor
class EventsViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    
    private let client: EventsClient = LadvEventsClient()
    
    func loadUpcomingEvents() async {
        events = await client.loadUpcomingEvents()
    }
}
