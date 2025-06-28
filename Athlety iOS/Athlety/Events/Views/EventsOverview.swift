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
                
                Section {
                    ForEach(viewModel.eventsByDate[date]!) { event in
                        EventRow(event: event)
                    }
                } header: {
                    sectionHeader(for: date)
                }
            }
        }
        .listRowSpacing(8)
        .task {
            await viewModel.loadUpcomingEvents()
        }
    }
    
    private func sectionHeader(for date: Date) -> some View {
        Text(date.formatted(.dateTime.weekday(.wide).day(.twoDigits).month(.wide).year()))
            .font(.callout)
            .foregroundColor(.primary)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
    }
}

#Preview {
    EventsOverview()
        .environmentObject(EventsOverviewViewModel())
}
