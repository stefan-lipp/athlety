//
//  EventDetailsViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 11.07.25.
//

import Foundation
import TipKit

@Observable
final class EventDetailsViewModel {
    private(set) var event: EventDetails?

    private let client: EventsClient = LadvEventsClient()

    func loadEventDetails(for eventId: Int) async {
        event = await client.loadEventDetails(for: eventId)
        if event != nil {
            await BookmarkTip.eventDetailsViewed.donate()
        }
    }
}
