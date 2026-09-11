//
//  EventsLoadingRows.swift
//  Athlety
//
//  Created by Stefan Lipp on 25.08.25.
//

import SwiftUI

/// Redacted placeholder sections shown while upcoming events are being loaded.
///
/// Reuses ``EventRow`` so the skeleton always matches the real row layout.
struct EventsLoadingRows: View {
    private static let sampleEvents: [[Event]] = [
        [
            Event(id: -1, name: "Sportfest der Leichtathleten", location: "Rheinfelden", date: .now, isCancelled: false),
            Event(id: -2, name: "Abendsportfest", location: "Karlsruhe", date: .now, isCancelled: false),
            Event(id: -3, name: "Kreismeisterschaften Mehrkampf", location: "Freiburg im Breisgau", date: .now, isCancelled: false),
        ],
        [
            Event(id: -4, name: "Läufermeeting", location: "Offenburg", date: .now, isCancelled: false),
            Event(id: -5, name: "Landesmeisterschaften der Aktiven", location: "Mannheim", date: .now, isCancelled: false),
        ],
    ]

    var body: some View {
        ForEach(Array(Self.sampleEvents.enumerated()), id: \.offset) { _, events in
            Section {
                ForEach(events) { event in
                    EventRow(event: event, isSaved: false)
                }
            } header: {
                EventsSectionHeader(date: .now)
            }
        }
        .redacted(reason: .placeholder)
        .allowsHitTesting(false)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Loading events")
    }
}

#Preview {
    List {
        EventsLoadingRows()
    }
    .listRowSpacing(8)
}
