//
//  EventRow.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventRow: View {
    let event: Event
    let isSaved: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                eventLocation
                if event.isCancelled {
                    eventLabel("Cancelled", fontWeight: .semibold, background: .accent)
                } else if event.isWorldRankingsCompetition {
                    eventLabel("WRC", fontWeight: .bold, background: .wrcPurple)
                }
                Spacer()
                eventDate
                chevron
            }
            HStack(alignment: .bottom) {
                eventName
                Spacer()
                bookmarkIcon
            }
        }
    }

    private var eventLocation: some View {
        Text(event.location)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
    }

    private var bookmarkIcon: some View {
        Image(systemName: "bookmark.fill")
            .foregroundStyle(isSaved ? .accent : .clear)
    }

    private var eventDate: some View {
        Text(event.date, format: .dateTime.day().month())
            .font(.footnote)
            .foregroundStyle(.secondary)
    }

    private var chevron: some View {
        Image(systemName: "chevron.right")
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundStyle(.tertiary)
    }

    private var eventName: some View {
        Text(event.name)
            .fontWeight(.semibold)
    }

    private func eventLabel(_ title: LocalizedStringKey, fontWeight: Font.Weight, background: Color) -> some View {
        Text(title)
            .font(.caption)
            .fontWeight(fontWeight)
            .foregroundStyle(.white)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(background, in: Capsule())
    }
}

#Preview("Saved") {
    let event = Event(id: 44253, name: "36. Rheinfelder Nachtmeeting", location: "Rheinfelden", date: Date(), isCancelled: false)
    EventRow(event: event, isSaved: true)
        .padding()
}

#Preview("Cancelled") {
    let event = Event(id: 44253, name: "36. Rheinfelder Nachtmeeting", location: "Rheinfelden", date: Date(), isCancelled: true)
    EventRow(event: event, isSaved: false)
        .padding()
}

#Preview("World Rankings Competition") {
    let event = Event(
        id: 44253,
        name: "36. Rheinfelder Nachtmeeting",
        location: "Rheinfelden",
        date: Date(),
        isCancelled: false,
        isWorldRankingsCompetition: true
    )
    EventRow(event: event, isSaved: false)
        .padding()
}
