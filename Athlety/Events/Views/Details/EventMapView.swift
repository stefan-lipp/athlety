//
//  EventMapView.swift
//  Athlety
//
//  Created by Stefan Lipp on 23.11.25.
//

import MapKit
import SwiftUI

struct EventMapView: View {
    let latitude: Double
    let longitude: Double

    @State private var position: MapCameraPosition

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
        _position = State(
            initialValue: EventMapView.regionPosition(latitude: latitude, longitude: longitude)
        )
    }

    var body: some View {
        Map(position: $position, interactionModes: [])
            .onChange(of: [latitude, longitude]) {
                position = EventMapView.regionPosition(latitude: latitude, longitude: longitude)
            }
    }

    private static func regionPosition(latitude: Double, longitude: Double) -> MapCameraPosition {
        .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
        )
    }
}

#Preview {
    EventMapView(latitude: 51.3197, longitude: 9.49778)
}
