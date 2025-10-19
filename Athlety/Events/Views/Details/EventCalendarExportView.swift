//
//  EventCalendarExportView.swift
//  Athlety
//
//  Created by Stefan Lipp on 19.10.25.
//

import SwiftUI

struct EventCalendarExportView: View {
    
    let event: EventDetails
    
    @EnvironmentObject private var viewModel: CalendarEventViewModel
    
    var body: some View {
        Button {
            viewModel.addEventToCalendar(event)
        } label: {
            Label("Add to Calendar", systemImage: "calendar.badge.plus")
        }
        .padding(.vertical, 8)
        .sheet(isPresented: $viewModel.showCalendarEventEditView) {
            CalendarEventEditView(event: viewModel.calendarEvent, eventStore: viewModel.calendarEventStore)
        }
    }
}

#Preview {
    let location = EventLocation(name: "Rheinfelden", site: "Europastadion", latitude: 47.5611, longitude: 7.79167)
    let event = EventDetails(id: 44253, name: "Nachmeeting", date: Date(), location: location, attachements: [])
    EventCalendarExportView(event: event)
        .environmentObject(CalendarEventViewModel())
}
