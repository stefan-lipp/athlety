//
//  EventsFilterView.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsFilterView: View {

    @EnvironmentObject private var viewModel: EventsFilterViewModel

    @Environment(\.dismiss) private var dismiss

    @State private var selectedAssociationId: String?
    @State private var selectedDiscipline: Discipline?

    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    EventsFilterAssociationPicker(
                        associations: viewModel.associations,
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
            await viewModel.loadAssociations()
            selectedAssociationId = viewModel.eventsFilterAssociationId
            selectedDiscipline = viewModel.eventsFilterDiscipline
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
                viewModel.eventsFilterAssociationId = selectedAssociationId
                viewModel.eventsFilterDiscipline = selectedDiscipline
                dismiss()
            }
        }
    }

    private var associationDisplayName: LocalizedStringKey {
        if let id = selectedAssociationId, let association = viewModel.association(withId: id) {
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
