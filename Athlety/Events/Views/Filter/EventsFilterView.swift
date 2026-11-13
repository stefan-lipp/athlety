//
//  EventsFilterView.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsFilterView: View {
    var isAssociationOnly = false

    @Environment(EventsOverviewViewModel.self) private var viewModel

    @Environment(\.dismiss) private var dismiss

    @AppStorage("eventsFilterAssociationId") private var associationId: String?
    @AppStorage("eventsFilterDiscipline") private var discipline: Discipline?
    @AppStorage("eventsFilterWorldRankingsCompetition") private var isWorldRankingsCompetition = false

    @State private var selectedAssociationId: String?
    @State private var selectedDiscipline: Discipline?
    @State private var selectedIsWorldRankingsCompetition = false

    private var filter: EventsFilter {
        EventsFilter(
            associationId: selectedAssociationId,
            discipline: selectedDiscipline,
            isWorldRankingsCompetition: selectedIsWorldRankingsCompetition
        )
    }

    private var isResettable: Bool {
        isAssociationOnly ? selectedAssociationId != nil : filter.isActive
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
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
                    .disabled(isAssociationOnly)
                }

                Section {
                    Toggle(
                        "World Ranking Competitions Only",
                        isOn: isAssociationOnly ? .constant(false) : $selectedIsWorldRankingsCompetition
                    )
                    .tint(.accent)
                    .disabled(isAssociationOnly)
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
            selectedIsWorldRankingsCompetition = isWorldRankingsCompetition
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
                if !isAssociationOnly {
                    selectedDiscipline = nil
                    selectedIsWorldRankingsCompetition = false
                }
            }
            .disabled(!isResettable)
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Done", systemImage: "checkmark") {
                associationId = selectedAssociationId
                discipline = selectedDiscipline
                isWorldRankingsCompetition = selectedIsWorldRankingsCompetition
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
        guard !isAssociationOnly, let selectedDiscipline else { return String(localized: "All") }
        return selectedDiscipline.name
    }
}

#Preview {
    EventsFilterView()
        .environment(EventsOverviewViewModel())
}
