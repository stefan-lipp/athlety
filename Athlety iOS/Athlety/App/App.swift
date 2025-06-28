//
//  App.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI
import SwiftData

@main
struct AthletyApp: App {
    var body: some Scene {
        WindowGroup {
            let events = [Event(id: 44253, name: "Nachtmeeting", location: "Rheinfelden", date: Date())]
            EventsOverview(events: events)
        }
    }
}
