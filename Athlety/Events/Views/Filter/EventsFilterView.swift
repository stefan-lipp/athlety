//
//  EventsFilterView.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsFilterView: View {
    @Environment(EventsOverviewViewModel.self) private var viewModel

    @Environment(\.dismiss) private var dismiss

    @AppStorage("eventsFilterAssociationId") private var associationId: String?
    @AppStorage("eventsFilterDiscipline") private var discipline: Discipline?

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
            .toolbarTitleDisplayMode(.inline)
            .toolbar { toolbar }
        }
        .task {
            if viewModel.associations.isEmpty {
                await viewModel.loadAssociations()
            }
            selectedAssociationId = associationId
            selectedDiscipline = discipline
        }
    }

    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                dismiss()
            }
        }
        ToolbarItem {
            Button("Reset", systemImage: "arrow.counterclockwise") {
                selectedAssociationId = nil
                selectedDiscipline = nil
            }
            .disabled(selectedAssociationId == nil && selectedDiscipline == nil)
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Done", systemImage: "checkmark") {
                associationId = selectedAssociationId
                discipline = selectedDiscipline
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

    private var disciplineDisplayName: String {
        selectedDiscipline?.name ?? String(localized: "All")
    }
}

#Preview {
    EventsFilterView()
        .environment(EventsOverviewViewModel())
}
