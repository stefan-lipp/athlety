//
//  EventsFilterView.swift
//  Athlety
//
//  Created by Stefan Cimander on 19.05.23.
//

import SwiftUI

struct EventsFilterView: View {
    
    @EnvironmentObject var viewModel: EventsFilterViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var onFilter: (String?) -> Void
    
    var body: some View {
        NavigationStack {
            List {
                EventsFilterRow(name: "All",
                                isSelected: viewModel.selectedAssociation == nil,
                                onSelect: { viewModel.selectedAssociation = nil }
                )
                ForEach(viewModel.associations) { association in
                    EventsFilterRow(name: LocalizedStringKey(association.name),
                                    isSelected: viewModel.selectedAssociation == association,
                                    onSelect: { viewModel.selectedAssociation = association }
                    )
                }
            }
            .listStyle(.plain)
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    onFilter(viewModel.selectedAssociation?.id)
                    dismiss()
                } label: {
                    Text("Done")
                        .fontWeight(.semibold)
                }
            }
        }
        .task { await viewModel.loadAssociations() }
    }
}

struct EventsFilterView_Previews: PreviewProvider {
    static var previews: some View {
        EventsFilterView() { _ in }
            .environmentObject(EventsFilterViewModel())
    }
}
