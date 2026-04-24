//
//  EventsFilterViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 29.06.25.
//

import Combine
import SwiftUI

class EventsFilterViewModel: ObservableObject {
    @Published private(set) var associations: [Association] = []

    @AppStorage("eventsFilterAssociationId") var associationId: String?
    @AppStorage("eventsFilterDiscipline") var discipline: Discipline?

    private let client: AssociationsClient = LadvAssociationsClient()

    func loadAssociations() async {
        associations = await client.loadAssociations()
    }

    func association(withId associationId: String) -> Association? {
        associations.first(where: { $0.id == associationId })
    }
}
