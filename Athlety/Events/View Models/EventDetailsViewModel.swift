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
    
    @Published var eventStore = EKEventStore()
    @Published var calendarEvent: EKEvent?
    @Published var showCalendarAddEventView = false
    
    private let client: EventsClient = LadvEventsClient()
    
    func loadEventDetails(for eventId: Int) async {
        event = await client.loadEventDetails(for: eventId)
    }
    
    func addToCalendar() {
        guard let event else { return }
        
        let newCalendarEvent = EKEvent(eventStore: eventStore)
        newCalendarEvent.title = event.name
        newCalendarEvent.location = event.location.description
        newCalendarEvent.startDate = event.date
        newCalendarEvent.endDate = event.date
        newCalendarEvent.isAllDay = true
        newCalendarEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        calendarEvent = newCalendarEvent
        showCalendarAddEventView = true
    }
}
