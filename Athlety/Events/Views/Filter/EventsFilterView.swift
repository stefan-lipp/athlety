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

    var body: some View {
        NavigationStack {
            filterContent
                .navigationTitle("Filter")
                .toolbarTitleDisplayMode(.inline)
                .toolbar { toolbar }
        }
        #if os(macOS)
        .frame(minWidth: 420, idealWidth: 440, maxWidth: 600, minHeight: 320, idealHeight: 360, maxHeight: 600)
        .presentationSizing(.fitted)
        #else
        .presentationDetents(UIDevice.current.userInterfaceIdiom == .phone ? [.medium, .large] : [.large])
        .presentationBackground(Color(.systemGroupedBackground))
        #endif
        .task {
            selectedAssociationId = associationId
            selectedDiscipline = discipline
            selectedIsWorldRankingsCompetition = isWorldRankingsCompetition
            if viewModel.associations.isEmpty {
                await viewModel.loadAssociations()
            }
        }
    }

    #if os(macOS)
        private var filterContent: some View {
            Form {
                Section {
                    EventsFilterAssociationMenu(
                        associations: viewModel.associations,
                        selectedAssociationId: $selectedAssociationId
                    )
                    EventsFilterDisciplineMenu(selectedDiscipline: $selectedDiscipline)
                }

                worldRankingsSection
            }
            .formStyle(.grouped)
        }
    #else
        private var filterContent: some View {
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
                }

                worldRankingsSection
            }
        }

        private var associationDisplayName: String {
            if let id = selectedAssociationId, let association = viewModel.association(withId: id) {
                return association.name
            }
            return String(localized: "All")
        }

        private var disciplineDisplayName: String {
            selectedDiscipline?.name ?? String(localized: "All")
        }
    #endif

    private var worldRankingsSection: some View {
        Section {
            Toggle("World Ranking Competitions Only", isOn: $selectedIsWorldRankingsCompetition)
                .tint(.accent)
            #if os(macOS)
                .padding(.vertical, 4)
            #endif
        }
    }

    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                dismiss()
            }
            #if os(macOS)
            .labelStyle(.titleOnly)
            #endif
        }
        ToolbarItem {
            Button("Reset", systemImage: "arrow.counterclockwise", action: resetFilter)
                .disabled(!filter.isActive)
            #if os(macOS)
                .labelStyle(.titleOnly)
            #endif
        }
        ToolbarItem(placement: .confirmationAction) {
            Button("Done", systemImage: "checkmark", action: applyFilter)
            #if os(macOS)
                .labelStyle(.titleOnly)
            #endif
        }
    }

    // MARK: - Actions

    private func resetFilter() {
        selectedAssociationId = nil
        selectedDiscipline = nil
        selectedIsWorldRankingsCompetition = false
    }

    private func applyFilter() {
        associationId = selectedAssociationId
        discipline = selectedDiscipline
        isWorldRankingsCompetition = selectedIsWorldRankingsCompetition
        dismiss()
    }
}

#Preview {
    EventsFilterView()
        .environment(EventsOverviewViewModel())
}
