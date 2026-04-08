//
//  EventsFilterAssociationPicker.swift
//  Athlety
//
//  Created by Stefan Lipp on 05.04.26.
//

import SwiftUI

struct EventsFilterAssociationPicker: View {
    let associations: [Association]
    @Binding var selectedAssociationId: String?

    var body: some View {
        List {
            EventsFilterRow(
                name: "All",
                isSelected: selectedAssociationId == nil,
                onSelect: { selectedAssociationId = nil }
            )

            ForEach(associations) { association in
                EventsFilterRow(
                    name: LocalizedStringKey(association.name),
                    isSelected: selectedAssociationId == association.id,
                    onSelect: { selectedAssociationId = association.id }
                )
            }
        }
        .navigationTitle("Association")
        .environment(\.defaultMinListRowHeight, 56)
    }
}
