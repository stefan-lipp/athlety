//
//  EventsViewModel.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import Foundation
import Combine

@MainActor
class EventsViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    
    private let client = EventsClient()
    
    func loadUpcomingEvents() async {
        events = await client.loadUpcomingEvents()
    }
}
