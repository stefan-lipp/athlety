//
//  CalendarEventViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 19.10.25.
//

import Combine
import EventKit

@MainActor
class CalendarEventViewModel: ObservableObject {
    private(set) var calendarEventStore = EKEventStore()

    @Published var calendarEvent: EKEvent?

    func addEventToCalendar(_ event: Event) {
        let newCalendarEvent = EKEvent(eventStore: calendarEventStore)
        newCalendarEvent.title = event.name
        newCalendarEvent.location = event.location
        newCalendarEvent.startDate = event.date
        newCalendarEvent.endDate = event.date
        newCalendarEvent.isAllDay = true
        newCalendarEvent.calendar = calendarEventStore.defaultCalendarForNewEvents

        calendarEvent = newCalendarEvent
    }
}
