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
}
