//
//  EventDetails.swift
//  Athlety
//
//  Created by Stefan Lipp on 11.07.25.
//

import Foundation

struct EventDetails: Identifiable {
    let id: Int
    let name: String
    let date: Date
    let isCancelled: Bool
    let note: String?
    let location: EventLocation
    let registration: EventRegistration
    let links: [EventLink]
    let attachments: [EventAttachment]
    let disciplines: [EventDiscipline]
    
    var deduplicatedDisciplines: [Discipline] {
        let uniqueDisciplines = disciplines.map { $0.discipline }.unique()
        return Discipline.allCases.filter { uniqueDisciplines.contains($0) }
    }
}

struct EventLocation: CustomStringConvertible {
    let name: String
    let site: String
    let latitude: Double
    let longitude: Double
    
    var description: String {
        "\(site), \(name)"
    }
}

struct EventRegistration {
    let deadline: Date
    let email: String
}

struct EventLink {
    let name: String
    let url: URL
}

struct EventAttachment {
    let name: String
    let url: URL
}

struct EventDiscipline {
    let discipline: Discipline
    let ageGroup: String
}
