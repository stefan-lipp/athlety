//
//  App.swift
//  Athlety
//
//  Created by Stefan Cimander on 15.05.23.
//

import SwiftUI

@main
struct AthletyApp: App {
    
    @ObservedObject private var eventsViewModel = EventsViewModel()
    
    var body: some Scene {
        WindowGroup {
            EventsView()
                .environmentObject(eventsViewModel)
        }
    }
}
