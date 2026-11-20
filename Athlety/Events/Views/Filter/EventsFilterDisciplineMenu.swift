//
//  EventsFilterDisciplineMenu.swift
//  Athlety
//
//  Created by Stefan Lipp on 20.11.26.
//

#if os(macOS)
    import SwiftUI

    struct EventsFilterDisciplineMenu: View {
        @Binding var selectedDiscipline: Discipline?

        private var selectedDisciplineName: String {
            selectedDiscipline?.name ?? String(localized: "All")
        }

        var body: some View {
            LabeledContent("Discipline") {
                Menu(selectedDisciplineName) {
                    options {
                        Text("All")
                            .tag(Discipline?.none)
                    }
                    Divider()
                    ForEach(Discipline.Category.allCases) { category in
                        Menu(category.name) {
                            options {
                                disciplineTags(Discipline.disciplines(for: category))
                            }
                        }
                    }
                    Divider()
                    options {
                        disciplineTags([.childrensAthletics])
                    }
                }
                .fixedSize()
                .accessibilityLabel("Discipline")
                .accessibilityValue(selectedDisciplineName)
            }
        }

        private func options(@ViewBuilder content: () -> some View) -> some View {
            Picker("Discipline", selection: $selectedDiscipline, content: content)
                .pickerStyle(.inline)
                .labelsHidden()
        }

        private func disciplineTags(_ disciplines: [Discipline]) -> some View {
            ForEach(disciplines) { discipline in
                Text(discipline.name)
                    .tag(Optional(discipline))
            }
        }
    }
#endif
