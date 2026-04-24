//
//  EventCalendarExportView.swift
//  Athlety
//
//  Created by Stefan Lipp on 19.10.25.
//

import SwiftUI

struct EventCalendarExportView: View {
    let event: Event

    @EnvironmentObject private var calendarEventViewModel: CalendarEventViewModel

    @State private var showCalendarEventEditView = false

    var body: some View {
        Button {
            calendarEventViewModel.addEventToCalendar(event)
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
    let event = Event(id: 44253, name: "Nachmeeting", location: "Rheinfelden", date: Date(), isCancelled: false)

    EventCalendarExportView(event: event)
        .environmentObject(CalendarEventViewModel())
}
