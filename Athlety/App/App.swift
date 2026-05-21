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
    @State private var calendarEventViewModel = CalendarEventViewModel()
    @State private var eventsOverviewViewModel = EventsOverviewViewModel()

    @AppStorage("showOnboarding") private var showAppOnboarding = true
    @AppStorage("appAppearance") private var appAppearance: Appearance = .system

    var body: some Scene {
        WindowGroup {
            EventsOverview()
                .environment(calendarEventViewModel)
                .environment(eventsOverviewViewModel)
                .preferredColorScheme(appAppearance.colorScheme)
                .sheet(isPresented: $showAppOnboarding) {
                    WelcomeView()
                }
        }
        .modelContainer(for: EventBookmark.self)
    }
}
