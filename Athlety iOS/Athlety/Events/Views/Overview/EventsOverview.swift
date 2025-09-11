//
//  EventsOverview.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsOverview: View {
    
    @EnvironmentObject private var eventsOverviewViewModel: EventsOverviewViewModel
    @EnvironmentObject private var eventsFilterViewModel: EventsFilterViewModel
    
    @State private var showFilter = false
    
    var body: some View {
        NavigationStack {
            EventsList(eventsByDate: eventsOverviewViewModel.eventsByDate)
                .navigationTitle("Events")
                .toolbar { toolbar }
                .sheet(isPresented: $showFilter) {
                    EventsFilterView()
                }
        }
        .task {
            let associationId = eventsFilterViewModel.eventsFilterAssociationId
            await eventsOverviewViewModel.loadUpcomingEvents(for: associationId)
        }
        .onChange(of: eventsFilterViewModel.eventsFilterAssociationId) {
            Task {
                let associationId = eventsFilterViewModel.eventsFilterAssociationId
                await eventsOverviewViewModel.loadUpcomingEvents(for: associationId)
            }
        }
    }
    
    private func sectionHeader(for date: Date) -> some View {
        Text(date.formatted(.dateTime.weekday(.wide).day(.twoDigits).month(.wide).year()))
            .font(.callout)
            .foregroundColor(.primary)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
    }
    
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                showFilter = true
            } label: {
                Label("Filter", systemImage: "line.3.horizontal.decrease")
            }
        }
    }
}

#Preview {
    EventsOverview()
        .environmentObject(EventsOverviewViewModel())
        .environmentObject(EventsFilterViewModel())
        .environmentObject(EventDetailsViewModel())
}
