//
//  EventsClient.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import Foundation

protocol EventsClient {
    func loadUpcomingEvents(for associationId: String?) async -> [Event]
}
