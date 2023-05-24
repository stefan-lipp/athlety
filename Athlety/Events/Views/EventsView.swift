//
//  EventsView.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import SwiftUI

struct EventsView: View {
    
    @EnvironmentObject var eventsViewModel: EventsViewModel
    @EnvironmentObject var eventsFilterViewModel: EventsFilterViewModel
    
    @State private var showFilterView = false
    
    var body: some View {
        NavigationStack {
            List {
                let sortedEventDates = eventsViewModel.eventsByDate.keys.sorted(by: <)
                ForEach(sortedEventDates, id: \.self) { date in
                    Section(dateFormatter.string(from: date)) {
                        ForEach(eventsViewModel.eventsByDate[date]!) { event in
                            EventRow(event: event)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Events")
            .toolbar {
                Button {
                    showFilterView = true
                } label: {
                    let isFilterApplied = eventsFilterViewModel.selectedAssociation != nil
                    let imageName = "line.3.horizontal.decrease.circle\(isFilterApplied ? ".fill" : "")"
                    Label("Filter", systemImage: imageName)
                }
            }
            .sheet(isPresented: $showFilterView) {
                EventsFilterView() { associationId in
                    Task { await eventsViewModel.loadUpcomingEvents(for: associationId) }
                }
            }
        }
        .task { await eventsViewModel.loadUpcomingEvents(for: nil) }
    }
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .full
        return dateFormatter
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
            .environmentObject(EventsViewModel())
            .environmentObject(EventsFilterViewModel())
    }
}
