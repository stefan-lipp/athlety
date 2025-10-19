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
    
    init(id: Int, name: String, location: String, date: Date) {
        self.id = id
        self.name = name
        self.location = location
        self.date = date
    }
    
    init(event: EventDetails) {
        self.init(id: event.id, name: event.name, location: event.location.name, date: event.date)
    }
}
