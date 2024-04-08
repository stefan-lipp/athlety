//
//  EventDetailsViewModel.swift
//  Athlety
//
//  Created by Stefan Cimander on 01.06.23.
//

import SwiftUI
import EventKit

@MainActor
class EventDetailsViewModel: ObservableObject {
    
    @Published var event: EventDetails?
    
    @Published var calendarEvent: EKEvent?
    @Published var showCalendarAddEventView = false
    @Published var eventStore = EKEventStore()
    
    private let client: EventsClient = LadvEventsClient()
    
    func loadEventDetails(for eventId: Int) async {
        event = await client.loadEventDetails(for: eventId)
    }
    
    func addToCalendar() {
        guard let event else { return }
        
        let calendarEvent = EKEvent(eventStore: eventStore)
        calendarEvent.title = event.name
        calendarEvent.startDate = event.date
        calendarEvent.endDate = event.date
        calendarEvent.isAllDay = true
        calendarEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        showCalendarAddEventView = true
    }
}
