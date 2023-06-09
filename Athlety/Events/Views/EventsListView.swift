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
                Section(dateFormatter.string(from: date)) {
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
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter
    }
}

struct EventsListView_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView()
            .environmentObject(EventsViewModel())
            .environmentObject(EventsFilterStore())
    }
}
