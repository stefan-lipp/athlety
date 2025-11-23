//
//  EventMapView.swift
//  Athlety
//
//  Created by Stefan Lipp on 23.11.25.
//

import SwiftUI
import MapKit

struct EventMapView: View {
    
    let latitude: Double
    let longitude: Double
    
    var body: some View {
        Map(initialPosition: .region(region), interactionModes: [])
    }
    
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
}

#Preview {
    EventMapView(latitude: 51.3197, longitude: 9.49778)
}
