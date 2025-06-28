//
//  EventsList.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsList: View {
    let eventsByDate: [Date: [Event]]
    
    var body: some View {
        List {
            ForEach(eventsByDate.keys.sorted(by: <), id: \.self) { date in
                Section {
                    ForEach(eventsByDate[date]!) { event in
                        EventRow(event: event)
                    }
                } header: {
                    sectionHeader(for: date)
                }
            }
        }
        .listRowSpacing(8)
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
    let event = Event(id: 44253, name: "36. Rheinfelder Nachtmeeting", location: "Rheinfelden", date: Date())
    EventsList(eventsByDate: [event.date: [event]])
}
