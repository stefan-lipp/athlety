//
//  EventsClient.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import Foundation

@MainActor
protocol EventsClient {
    
    func loadUpcomingEvents(for associationId: String?) async -> [Event]
    
    func loadEventDetails(for eventId: Int) async -> EventDetails?
}
