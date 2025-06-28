//
//  EventsOverview.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsOverview: View {
    let events: [Event]
    
    var body: some View {
        List {
            ForEach(events) { event in
                EventRow(event: event)
            }
        }
    }
}

#Preview {
    let events = [Event(id: 44253, name: "Nachtmeeting", location: "Rheinfelden", date: Date())]
    EventsOverview(events: events)
}
