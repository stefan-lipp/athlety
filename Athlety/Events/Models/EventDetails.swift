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
    let note: String?
    let location: EventLocation
    let registration: EventRegistration
    let links: [EventLink]
    let attachements: [EventAttachement]
    let disciplines: [EventDiscipline]
    
    var deduplicatedDisciplines: [Discipline] {
        let uniqueDisciplines = disciplines.map { $0.discipline }.unique()
        return Discipline.allCases.filter { uniqueDisciplines.contains($0) }
    }
}
