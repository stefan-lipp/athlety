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

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        List {
            EventsFilterRow(
                name: "All",
                isSelected: selectedAssociationId == nil,
                onSelect: { selectAssociation(withId: nil) }
            )

            ForEach(associations) { association in
                EventsFilterRow(
                    name: LocalizedStringKey(association.name),
                    isSelected: selectedAssociationId == association.id,
                    onSelect: { selectAssociation(withId: association.id) }
                )
            }
        }
        .navigationTitle("Association")
        .environment(\.defaultMinListRowHeight, 56)
    }
    
    private func selectAssociation(withId associationId: String?) {
        selectedAssociationId = associationId
        dismiss()
    }
}
