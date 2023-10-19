//
//  EventLocationView.swift
//  Athlety
//
//  Created by Stefan Lipp on 20.10.23.
//

import SwiftUI

struct EventLocationView: View {
    
    let location: EventLocation
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Event Location")
                .fontWeight(.medium)
                .font(.title2)
                .padding(.vertical)
            
            EventMapView(latitude: location.latitude, longitude: location.longitude)
                .clipShape(RoundedRectangle(cornerRadius: 5))
                .frame(height: 256)
                .padding(.bottom)
            
            Text(location.name)
                .fontWeight(.medium)
            
            Text(location.site)
                .foregroundStyle(.secondary)
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
