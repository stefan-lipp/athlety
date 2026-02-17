//
//  EventCalendarExportView.swift
//  Athlety
//
//  Created by Stefan Lipp on 19.10.25.
//

import SwiftUI

struct EventCalendarExportView: View {
    let event: EventDetails

    @EnvironmentObject private var calendarEventViewModel: CalendarEventViewModel
    
    @State private var showCalendarEventEditView = false

    var body: some View {
        Button {
            calendarEventViewModel.addEventToCalendar(Event(event: event))
            showCalendarEventEditView = true
        } label: {
            Label("Add to Calendar", systemImage: "calendar.badge.plus")
        }
        .padding(.vertical, 8)
        .sheet(isPresented: $showCalendarEventEditView) {
            CalendarEventEditView(event: calendarEventViewModel.calendarEvent, eventStore: calendarEventViewModel.calendarEventStore)
        }
    }
}

#Preview {
    let location = EventLocation(name: "Rheinfelden", site: "Europastadion", latitude: 47.5611, longitude: 7.79167)
    let registration = EventRegistration(deadline: Date(), email: "anmeldung@nachtmeeting.de")
    let event = EventDetails(id: 44253, name: "Nachmeeting", date: Date(), note: nil, location: location, registration: registration, links: [], attachments: [], disciplines: [])
    
    EventCalendarExportView(event: event)
        .environmentObject(CalendarEventViewModel())
}
