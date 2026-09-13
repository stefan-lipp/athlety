//
//  EventClient.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Foundation

nonisolated protocol EventsClient: Sendable {
    func loadUpcomingEvents(
        for associationId: String?,
        and discipline: Discipline?,
        isWorldRankingsCompetition: Bool
    ) async -> [Event]
    func loadEventDetails(for eventId: Int) async -> EventDetails?
}
