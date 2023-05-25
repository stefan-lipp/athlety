//
//  EventsFilterViewModel.swift
//  Athlety
//
//  Created by Stefan Cimander on 24.05.23.
//

import SwiftUI

@MainActor
class EventsFilterViewModel: ObservableObject {
    
    @Published var associations: [Association] = []
    @Published var selectedAssociationId: String?
    
    private let client: AssociationsClient = LadvAssociationsClient()
    
    func loadAssociations() async {
        associations = await client.loadAssociations()
    }
    
    func synchronizeEventsFilter(with associationId: String?) {
        selectedAssociationId = associationId
    }
}
