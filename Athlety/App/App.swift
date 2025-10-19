//
//  App.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftData
import SwiftUI

@main
struct AthletyApp: App {
    
    @ObservedObject private var calendarEventViewModel = CalendarEventViewModel()
    @ObservedObject private var eventsOverviewViewModel = EventsOverviewViewModel()
    @ObservedObject private var eventsFilterViewModel = EventsFilterViewModel()
    @ObservedObject private var eventDetailsViewModel = EventDetailsViewModel()
    
    var body: some Scene {
        WindowGroup {
            EventsOverview()
                .environmentObject(calendarEventViewModel)
                .environmentObject(eventsOverviewViewModel)
                .environmentObject(eventsFilterViewModel)
                .environmentObject(eventDetailsViewModel)
        }
        .modelContainer(for: EventBookmark.self)
    }
}
