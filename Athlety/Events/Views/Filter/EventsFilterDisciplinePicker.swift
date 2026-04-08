//
//  EventsFilterDisciplinePicker.swift
//  Athlety
//
//  Created by Stefan Lipp on 05.04.26.
//

import SwiftUI

struct EventsFilterDisciplinePicker: View {
    @Binding var selectedDiscipline: Discipline?

    var body: some View {
        List {
            EventsFilterRow(
                name: "All",
                isSelected: selectedDiscipline == nil,
                onSelect: { selectedDiscipline = nil }
            )

            ForEach(Discipline.Category.allCases) { category in
                Section(category.localized) {
                    ForEach(Discipline.disciplines(for: category)) { discipline in
                        EventsFilterRow(
                            name: discipline.localized,
                            isSelected: selectedDiscipline == discipline,
                            onSelect: { selectedDiscipline = discipline }
                        )
                    }
                }
            }

            EventsFilterRow(
                name: "Children's Athletics",
                isSelected: selectedDiscipline == .childrensAthletics,
                onSelect: { selectedDiscipline = .childrensAthletics }
            )
        }
        .navigationTitle("Discipline")
        .environment(\.defaultMinListRowHeight, 56)
    }
}
