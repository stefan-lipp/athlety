//
//  EventsFilterStore.swift
//  Athlety
//
//  Created by Stefan Cimander on 25.05.23.
//

import SwiftUI

@MainActor
class EventsFilterStore: ObservableObject {
    
    @AppStorage("eventsFilterAssociationId") var associationId: String?
    
}
