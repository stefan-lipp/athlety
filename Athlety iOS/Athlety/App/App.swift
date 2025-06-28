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
    
    var body: some Scene {
        WindowGroup {
            EventsOverview()
                .environmentObject(eventsOverviewViewModel)
        }
    }
}
