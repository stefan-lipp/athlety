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
    
    @State private var searchText = ""

    private var isSearching: Bool {
        !searchText.isEmpty
    }

    private var filteredAssociations: [Association] {
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespaces)
        return associations.filter { association in
            association.name.localizedCaseInsensitiveContains(trimmedSearchText)
        }
    }

    var body: some View {
        List {
            if isSearching {
                searchResults
            } else {
                associationSections
            }
        }
        .navigationTitle("Association")
        .environment(\.defaultMinListRowHeight, 56)
        .searchable(text: $searchText)
        .overlay { associationNotFoundOverlay }
    }
    
    private var searchResults: some View {
        ForEach(filteredAssociations) { association in
            EventsFilterRow(
                name: association.name,
                isSelected: selectedAssociationId == association.id,
                onSelect: { selectAssociation(withId: association.id) }
            )
        }
    }
    
    @ViewBuilder
    private var associationSections: some View {
        Section {
            EventsFilterRow(
                name: String(localized: "All"),
                isSelected: selectedAssociationId == nil,
                onSelect: { selectAssociation(withId: nil) }
            )
        }
        ForEach(associations) { association in
            EventsFilterRow(
                name: association.name,
                isSelected: selectedAssociationId == association.id,
                onSelect: { selectAssociation(withId: association.id) }
            )
        }
    }
    
    @ViewBuilder
    private var associationNotFoundOverlay: some View {
        if isSearching && filteredAssociations.isEmpty {
            ContentUnavailableView("Association not found", systemImage: "magnifyingglass")
                .foregroundStyle(.secondary)
        }
    }
    
    // MARK: - Actions
    
    private func selectAssociation(withId associationId: String?) {
        selectedAssociationId = associationId
        dismiss()
    }
}
