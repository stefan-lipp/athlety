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
    
    init(id: Int, name: String, location: String, date: Date) {
        self.id = id
        self.name = name
        self.location = location
        self.date = date
    }
    
    convenience init (event: Event) {
        self.init(id: event.id, name: event.name, location: event.location, date: event.date)
    }
}
