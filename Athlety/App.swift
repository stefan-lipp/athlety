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
    @ObservedObject private var eventDetailsViewModel = EventDetailsViewModel()
    
    @ObservedObject private var eventsFilterStore = EventsFilterStore()
    @ObservedObject private var eventsFilterViewModel = EventsFilterViewModel()
    
    @ObservedObject private var profileViewModel = ProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                EventsView()
                    .environmentObject(eventsViewModel)
                    .environmentObject(eventDetailsViewModel)
                    .environmentObject(eventsFilterStore)
                    .environmentObject(eventsFilterViewModel)
                    .tabItem { Label("Events", systemImage: "trophy") }
                ProfileView()
                    .environmentObject(profileViewModel)
                    .tabItem { Label("Profile", systemImage: "person")}
            }
            
            
        }
    }
}
