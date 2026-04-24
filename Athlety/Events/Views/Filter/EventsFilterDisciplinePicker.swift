//
//  EventsFilterDisciplinePicker.swift
//  Athlety
//
//  Created by Stefan Lipp on 05.04.26.
//

import SwiftUI

struct EventsFilterDisciplinePicker: View {
    @Binding var selectedDiscipline: Discipline?

    @Environment(\.dismiss) private var dismiss

    @State private var searchText = ""

    private var isSearching: Bool {
        !searchText.isEmpty
    }

    private var filteredDisciplines: [Discipline] {
        let trimmedSearchText = searchText.trimmingCharacters(in: .whitespaces)
        return Discipline.allCases.filter { discipline in
            discipline.displayName.localizedCaseInsensitiveContains(trimmedSearchText)
        }
    }

    var body: some View {
        List {
            if isSearching {
                searchResults
            } else {
                disciplineSections
            }
        }
        .navigationTitle("Discipline")
        .environment(\.defaultMinListRowHeight, 56)
        .searchable(text: $searchText)
        .overlay { disciplineNotFoundOverlay }
    }

    private var searchResults: some View {
        ForEach(filteredDisciplines) { discipline in
            EventsFilterRow(
                name: discipline.displayName,
                isSelected: selectedDiscipline == discipline,
                onSelect: { selectDiscipline(discipline) }
            )
        }
    }

    @ViewBuilder
    private var disciplineSections: some View {
        Section {
            EventsFilterRow(
                name: String(localized: "All"),
                isSelected: selectedDiscipline == nil,
                onSelect: { selectDiscipline(nil) }
            )
        }
        ForEach(Discipline.Category.allCases) { category in
            Section(category.displayName) {
                ForEach(Discipline.disciplines(for: category)) { discipline in
                    EventsFilterRow(
                        name: discipline.displayName,
                        isSelected: selectedDiscipline == discipline,
                        onSelect: { selectDiscipline(discipline) }
                    )
                }
            }
        }
        Section {
            EventsFilterRow(
                name: Discipline.childrensAthletics.displayName,
                isSelected: selectedDiscipline == .childrensAthletics,
                onSelect: { selectDiscipline(.childrensAthletics) }
            )
        }
    }

    @ViewBuilder
    private var disciplineNotFoundOverlay: some View {
        if isSearching && filteredDisciplines.isEmpty {
            ContentUnavailableView("Discipline not found", systemImage: "magnifyingglass")
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Actions

    private func selectDiscipline(_ discipline: Discipline?) {
        selectedDiscipline = discipline
        dismiss()
    }
}
