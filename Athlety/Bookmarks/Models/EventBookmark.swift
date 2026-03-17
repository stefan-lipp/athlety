//
//  EventBookmark.swift
//  Athlety
//
//  Created by Stefan Lipp on 11.09.25.
//

import Foundation
import SwiftData

@Model
class EventBookmark {
    var id: Int = 0
    var name: String = ""
    var location: String = ""
    var date: Date = Date()
    var isCancelled: Bool = false
    
    init(id: Int, name: String, location: String, date: Date, isCancelled: Bool) {
        self.id = id
        self.name = name
        self.location = location
        self.date = date
        self.isCancelled = isCancelled
    }
    
    convenience init(event: Event) {
        self.init(id: event.id, name: event.name, location: event.location, date: event.date, isCancelled: event.isCancelled)
    }
    
    convenience init(event: EventDetails) {
        self.init(id: event.id, name: event.name, location: event.location.name, date: event.date, isCancelled: event.isCancelled)
    }
    
    func toEvent() -> Event {
        Event(id: id, name: name, location: location, date: date, isCancelled: isCancelled)
    }
}
