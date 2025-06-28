//
//  EventsFilterViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 29.06.25.
//

import Combine

class EventsFilterViewModel: ObservableObject {
    
    @Published var associations: [Association] = []
    
    private let client: AssociationsClient = LadvAssociationsClient()
    
    func loadAssociations() async {
        associations = await client.loadAssociations()
    }
}
