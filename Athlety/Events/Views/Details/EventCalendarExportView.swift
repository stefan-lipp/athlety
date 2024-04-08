//
//  EventCalendarExportView.swift
//  Athlety
//
//  Created by Stefan Lipp on 04.04.24.
//

import SwiftUI

struct EventCalendarExportView: View {
    
    let event: EventDetails
    
    @EnvironmentObject private var viewModel: EventDetailsViewModel
    
    var body: some View {
        Button(action: viewModel.addToCalendar, label: {
            Label("Add to your Calendar", systemImage: "calendar.badge.plus")
        })
        .padding(.vertical, 8)
        .sheet(isPresented: $viewModel.showCalendarAddEventView) {
            CalendarAddEventView(event: $viewModel.calendarEvent, eventStore: viewModel.eventStore)
        }
    }
}
