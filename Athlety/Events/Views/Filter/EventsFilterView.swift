//
//  EventsFilterView.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsFilterView: View {

    @EnvironmentObject private var filterViewModel: EventsFilterViewModel

    @Environment(\.dismiss) private var dismiss

    @State private var selectedAssociationId: String?
    @State private var selectedDiscipline: Discipline?

    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    EventsFilterAssociationPicker(
                        associations: filterViewModel.associations,
                        selectedAssociationId: $selectedAssociationId
                    )
                } label: {
                    LabeledContent {
                        Text(associationDisplayName)
                    } label: {
                        Text("Association")
                    }
                }

                NavigationLink {
                    EventsFilterDisciplinePicker(selectedDiscipline: $selectedDiscipline)
                } label: {
                    LabeledContent {
                        Text(disciplineDisplayName)
                    } label: {
                        Text("Discipline")
                    }
                }
            }
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbar }
        }
        .task {
            await filterViewModel.loadAssociations()
            selectedAssociationId = filterViewModel.associationId
            selectedDiscipline = filterViewModel.discipline
        }
    }

    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                dismiss()
            }
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Done", systemImage: "checkmark") {
                filterViewModel.associationId = selectedAssociationId
                filterViewModel.discipline = selectedDiscipline
                dismiss()
            }
        }
    }

    private var associationDisplayName: LocalizedStringKey {
        if let id = selectedAssociationId, let association = filterViewModel.association(withId: id) {
            return LocalizedStringKey(association.name)
        }
        return "All"
    }

    private var disciplineDisplayName: LocalizedStringKey {
        selectedDiscipline?.localized ?? "All"
    }
}

#Preview {
    EventsFilterView()
        .environmentObject(EventsFilterViewModel())
}
