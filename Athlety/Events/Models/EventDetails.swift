//
//  EventDetails.swift
//  Athlety
//
//  Created by Stefan Lipp on 11.07.25.
//

import Foundation

nonisolated struct EventDetails: Identifiable, Sendable {
    let id: Int
    let name: String
    let date: Date
    let isCancelled: Bool
    let isWorldRankingsCompetition: Bool
    let note: String?
    let location: EventLocation
    let url: URL?
    let registration: EventRegistration
    let links: [EventLink]
    let attachments: [EventAttachment]
    let disciplines: [EventDiscipline]

    var deduplicatedDisciplines: [Discipline] {
        let uniqueDisciplines = disciplines.map(\.discipline).unique()
        return Discipline.allCases.filter { uniqueDisciplines.contains($0) }
    }
}

nonisolated struct EventLocation: CustomStringConvertible, Sendable {
    let name: String
    let site: String
    let latitude: Double
    let longitude: Double

    var description: String {
        "\(site), \(name)"
    }
}

nonisolated struct EventRegistration: Sendable {
    let host: String
    let email: String
    let deadline: Date
}

nonisolated struct EventLink: Sendable {
    let name: String
    let url: URL
}

nonisolated struct EventAttachment: Sendable {
    let name: String
    let url: URL
}

nonisolated struct EventDiscipline: Sendable {
    let discipline: Discipline
    let ageGroup: String
}
