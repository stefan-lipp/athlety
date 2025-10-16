//
//  EventsOverview.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftData
import SwiftUI

struct EventsOverview: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject private var eventsOverviewViewModel: EventsOverviewViewModel
    @EnvironmentObject private var eventsFilterViewModel: EventsFilterViewModel
    
    @Query private var eventBookmarks: [EventBookmark]
    
    @State private var showFilter = false
    @State private var selectedCategory: EventsOverviewCategory = .upcoming
    
    private var savedEvents: [Event] {
        eventBookmarks.map { $0.toEvent() }
    }
    
    var body: some View {
        NavigationStack {
            EventsList(
                selectedCategory: $selectedCategory,
                upcomingEvents: eventsOverviewViewModel.upcomingEvents,
                savedEvents: savedEvents,
                onSaveAsBookmark: { eventsOverviewViewModel.saveEventAsBookmark($0, in: modelContext) },
                onRemoveFromBookmarks: { eventsOverviewViewModel.removeEventFromBookmarks($0, in: modelContext) }
            )
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
            if selectedCategory == .upcoming {
                Button {
                    showFilter = true
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease")
                }
            }
        }
    }
}

enum EventsOverviewCategory {
    case upcoming
    case saved

    var icon: String {
        self == .upcoming ? "square.stack" : "bookmark"
    }

    var title: LocalizedStringKey {
        self == .upcoming ? "Upcoming" : "Saved"
    }
    
    var color: Color {
        self == .upcoming ? .accent : .orange
    }
}

#Preview {
    EventsOverview()
        .environmentObject(EventsOverviewViewModel())
        .environmentObject(EventsFilterViewModel())
        .environmentObject(EventDetailsViewModel())
}
