//
//  Event.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Foundation

struct Event: Identifiable {
    let id: Int
    let name: String
    let location: String
    let date: Date
    let isCancelled: Bool

    init(id: Int, name: String, location: String, date: Date, isCancelled: Bool) {
        self.id = id
        self.name = name
        self.location = location
        self.date = date
        self.isCancelled = isCancelled
    }

    init(event: EventDetails) {
        self.init(id: event.id, name: event.name, location: event.location.name, date: event.date, isCancelled: event.isCancelled)
    }
}
