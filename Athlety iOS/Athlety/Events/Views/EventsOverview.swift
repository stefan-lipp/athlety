//
//  EventsOverview.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsOverview: View {
    
    @EnvironmentObject var viewModel: EventsOverviewViewModel
    
    var body: some View {
        List {
            let sortedEventDates = viewModel.eventsByDate.keys.sorted(by: <)
            ForEach(sortedEventDates, id: \.self) { date in
                let formattedDate = date.formatted(.dateTime.weekday(.wide).day().month(.wide).year())
                Section(formattedDate) {
                    ForEach(viewModel.eventsByDate[date]!) { event in
                        EventRow(event: event)
                    }
                }
            }
        }
        .task {
            await viewModel.loadUpcomingEvents()
        }
    }
}

#Preview {
    EventsOverview()
        .environmentObject(EventsOverviewViewModel())
}
