//
//  EventDetailsView.swift
//  Athlety
//
//  Created by Stefan Cimander on 26.05.23.
//

import SwiftUI

struct EventDetailsView: View {
    
    let event: Event
    
    var body: some View {
        Text(event.name)
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(event: Event(id: 1, name: "Nachtmeeting", location: "Rheinfelden", date: Date()))
    }
}
