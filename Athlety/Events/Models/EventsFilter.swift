//
//  EventsFilter.swift
//  Athlety
//
//  Created by Stefan Lipp on 25.08.25.
//

import Foundation

/// The criteria the upcoming events request is narrowed down by.
nonisolated struct EventsFilter: Hashable, Sendable {
    let associationId: String?
    let discipline: Discipline?
    let isWorldRankingsCompetition: Bool

    var isActive: Bool {
        associationId != nil || discipline != nil || isWorldRankingsCompetition
    }
}
