//
//  EventsView.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import SwiftUI

struct EventsView: View {
    
    @EnvironmentObject var eventsViewModel: EventsViewModel
    @EnvironmentObject var eventsFilterStore: EventsFilterStore
    
    @State private var showFilterView = false
    
    var body: some View {
        NavigationView {
            EventsListView()
                .navigationTitle("Events")
                .toolbar {
                    Button {
                        showFilterView = true
                    } label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease")
                            .symbolVariant(eventsFilterStore.associationId == nil ? .circle : .circle.fill)
                    }
                }
                .sheet(isPresented: $showFilterView) {
                    EventsFilterView() {
                        Task { await eventsViewModel.loadUpcomingEvents(for: eventsFilterStore.associationId) }
                    }
                }
        }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
            .environmentObject(EventsViewModel())
            .environmentObject(EventDetailsViewModel())
            .environmentObject(EventsFilterStore())
            .environmentObject(EventsFilterViewModel())
    }
}
