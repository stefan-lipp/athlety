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
    @StateObject private var calendarEventViewModel = CalendarEventViewModel()
    @StateObject private var eventsOverviewViewModel = EventsOverviewViewModel()
    @StateObject private var eventsFilterViewModel = EventsFilterViewModel()
    
    @StateObject private var settingsStore = SettingsStore()

    var body: some Scene {
        WindowGroup {
            EventsOverview()
                .environmentObject(calendarEventViewModel)
                .environmentObject(eventsOverviewViewModel)
                .environmentObject(eventsFilterViewModel)
                .environmentObject(settingsStore)
                .preferredColorScheme(settingsStore.colorScheme)
                .sheet(isPresented: $settingsStore.showAppOnboarding) {
                    WelcomeView()
                }
        }
        .modelContainer(for: EventBookmark.self)
    }
}
