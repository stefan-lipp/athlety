//
//  EventsFilterAssociationMenu.swift
//  Athlety
//
//  Created by Stefan Lipp on 20.11.26.
//

#if os(macOS)
    import SwiftUI

    struct EventsFilterAssociationMenu: View {
        let associations: [Association]
        @Binding var selectedAssociationId: String?

        private var selectedAssociationName: String {
            associations.first { $0.id == selectedAssociationId }?.name ?? String(localized: "All")
        }

        var body: some View {
            LabeledContent("Association") {
                Menu(selectedAssociationName) {
                    options {
                        Text("All")
                            .tag(String?.none)
                    }
                    Divider()
                    options {
                        ForEach(associations) { association in
                            Text(association.name)
                                .tag(Optional(association.id))
                        }
                    }
                }
                .fixedSize()
                .accessibilityLabel("Association")
                .accessibilityValue(selectedAssociationName)
            }
            .padding(.vertical, 4)
        }

        private func options(@ViewBuilder content: () -> some View) -> some View {
            Picker("Association", selection: $selectedAssociationId, content: content)
                .pickerStyle(.inline)
                .labelsHidden()
        }
    }
#endif
