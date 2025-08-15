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
    
    @ObservedObject private var eventsOverviewViewModel = EventsOverviewViewModel()
    @ObservedObject private var eventsFilterViewModel = EventsFilterViewModel()
    @ObservedObject private var eventDetailsViewModel = EventDetailsViewModel()
    
    var body: some Scene {
        WindowGroup {
            EventsOverview()
                .environmentObject(eventsOverviewViewModel)
                .environmentObject(eventsFilterViewModel)
                .environmentObject(eventDetailsViewModel)
        }
    }
}
