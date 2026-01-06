//
//  EventLocationView.swift
//  Athlety
//
//  Created by Stefan Lipp on 23.11.25.
//

import SwiftUI

import SwiftUI

struct EventLocationView: View {
    
    let location: EventLocation
    
    var body: some View {
        VStack(alignment: .leading) {
            ListSectionHeader(title: "Event Location")
            
            EventMapView(latitude: location.latitude, longitude: location.longitude)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(height: 256)
                .padding(.vertical)
            
            Text(location.name)
                .fontWeight(.medium)
            
            Text(location.site)
                .foregroundStyle(.secondary)
                .padding(.bottom)
        }
    }
}

#Preview {
    let location = EventLocation(
        name: "Oberschleißheim",
        site: "Stadion an der Jahnstraße",
        latitude: 48.25,
        longitude: 11.5667
    )
    return EventLocationView(location: location)
}
