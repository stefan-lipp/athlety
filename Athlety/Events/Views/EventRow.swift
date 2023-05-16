//
//  EventRow.swift
//  Athlety
//
//  Created by Stefan Cimander on 17.05.23.
//

import SwiftUI

struct EventRow: View {
    let event: Event
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.name)
                .font(.headline)
                .lineLimit(2)
            Text(event.location)
                .fontWeight(.light)
        }
    }
}

struct EventRow_Previews: PreviewProvider {
    static var previews: some View {
        EventRow(event: Event(id: 1, name: "Nachtmeeting", location: "Rheinfelden", date: Date()))
    }
}
