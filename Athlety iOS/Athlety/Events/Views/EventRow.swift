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
        VStack(alignment: .leading) {
            Text(event.name)
            Text(event.location)
                .font(.caption)
        }
    }
}

#Preview {
    let event = Event(id: 44253, name: "Nachtmeeting", location: "Rheinfelden", date: Date())
    EventRow(event: event)
}
