//
//  EventClient.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Foundation

protocol EventsClient {
    func loadUpcomingEvents(for associationId: String?) async -> [Event]
    func loadEventDetails(for eventId: Int) async -> EventDetails?
}
