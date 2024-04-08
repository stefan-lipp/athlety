//
//  EventsListView.swift
//  Athlety
//
//  Created by Stefan Cimander on 10.06.23.
//

import SwiftUI

struct EventsListView: View {
    
    @EnvironmentObject var eventsViewModel: EventsViewModel
    @EnvironmentObject var eventsFilterStore: EventsFilterStore
    
    var body: some View {
        List {
            let sortedEventDates = eventsViewModel.eventsByDate.keys.sorted(by: <)
            ForEach(sortedEventDates, id: \.self) { date in
                let formattedDate = date.formatted(.dateTime.weekday(.wide).day().month(.wide).year())
                Section(formattedDate) {
                    ForEach(eventsViewModel.eventsByDate[date]!) { event in
                        NavigationLink {
                            EventDetailsView(eventId: event.id)
                        } label: {
                            EventRow(event: event)
                        }
                    }
                }
                .listSectionSeparator(.hidden, edges: [.bottom])
            }
        }
        .listStyle(.plain)
        .task { await eventsViewModel.loadUpcomingEvents(for: eventsFilterStore.associationId) }
    }
}

struct EventsListView_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView()
            .environmentObject(EventsViewModel())
            .environmentObject(EventsFilterStore())
    }
}
