//
//  EventsView.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import SwiftUI

struct EventsView: View {
    
    @EnvironmentObject var viewModel: EventsViewModel
    
    var body: some View {
        NavigationStack {
            List {
                let sortedEventDates = viewModel.eventsByDate.keys.sorted(by: <)
                ForEach(sortedEventDates, id: \.self) { date in
                    Section(dateFormatter.string(from: date)) {
                        ForEach(viewModel.eventsByDate[date]!) { event in
                            EventRow(event: event)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Events")
        }
        .task { await viewModel.loadUpcomingEvents() }
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
    }
}
