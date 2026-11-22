//
//  App.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftData
import SwiftUI
import TipKit

@main
struct AthletyApp: App {
    @State private var calendarEventViewModel = CalendarEventViewModel()
    @State private var eventsOverviewViewModel = EventsOverviewViewModel()

    @AppStorage("showOnboarding") private var showAppOnboarding = true
    @AppStorage("appAppearance") private var appAppearance: Appearance = .system

    init() {
        try? Tips.configure([
            .displayFrequency(.immediate),
            .datastoreLocation(.applicationDefault),
        ])
    }

    var body: some Scene {
        #if os(macOS)
            Window("Athlety", id: "main") {
                content
                    .frame(minHeight: 480)
            }
            .modelContainer(for: EventBookmark.self)
        #else
            WindowGroup {
                content
            }
            .modelContainer(for: EventBookmark.self)
        #endif
    }

    private var content: some View {
        EventsOverview()
            .environment(calendarEventViewModel)
            .environment(eventsOverviewViewModel)
            .preferredColorScheme(appAppearance.colorScheme)
            .sheet(isPresented: $showAppOnboarding) {
                WelcomeView()
            }
    }
}
