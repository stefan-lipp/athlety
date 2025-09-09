//
//  EventRow.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventRow: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                eventLocation
                Spacer()
                eventDate
                chevron
            }
            eventName
        }
    }
    
    private var eventLocation: some View {
        Text(event.location)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
    }
    
    private var eventDate: some View {
        Text(event.date, format: .dateTime.day().month().year())
            .font(.footnote)
            .foregroundStyle(.secondary)
    }
    
    private var chevron: some View {
        Image(systemName: "chevron.right")
            .font(.footnote)
            .foregroundStyle(.secondary)
    }
    
    private var eventName: some View {
        Text(event.name)
            .fontWeight(.semibold)
    }
    
}

#Preview {
    let event = Event(id: 44253, name: "36. Rheinfelder Nachtmeeting", location: "Rheinfelden", date: Date())
    EventRow(event: event)
        .padding()
}
