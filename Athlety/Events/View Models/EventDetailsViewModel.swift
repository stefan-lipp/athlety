//
//  EventDetailsViewModel.swift
//  Athlety
//
//  Created by Stefan Cimander on 01.06.23.
//

import SwiftUI

@MainActor
class EventDetailsViewModel: ObservableObject {
    
    @Published var event: EventDetails?
    
    private let client: EventsClient = LadvEventsClient()
    
    func loadEventDetails(for eventId: Int) async {
        event = await client.loadEventDetails(for: eventId)
    }
}
