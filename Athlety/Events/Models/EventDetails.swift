//
//  EventDetails.swift
//  Athlety
//
//  Created by Stefan Cimander on 01.06.23.
//

import Foundation

struct EventDetails: Identifiable {
    let id: Int
    let name: String
    let date: Date
    let location: EventLocation
    let registration: EventRegistration
    
    let attachements: [Attachement]
    let disciplines: [Discipline]
}
