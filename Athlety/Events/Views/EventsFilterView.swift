//
//  EventsFilterView.swift
//  Athlety
//
//  Created by Stefan Cimander on 19.05.23.
//

import SwiftUI

struct EventsFilterView: View {
    
    @EnvironmentObject var store: EventsFilterStore
    @EnvironmentObject var viewModel: EventsFilterViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var onFilter: () -> Void
    
    var body: some View {
        NavigationStack {
            List {
                EventsFilterRow(name: "All",
                                isSelected: viewModel.selectedAssociationId == nil,
                                onSelect: { viewModel.selectedAssociationId = nil }
                )
                ForEach(viewModel.associations) { association in
                    EventsFilterRow(name: LocalizedStringKey(association.name),
                                    isSelected: viewModel.selectedAssociationId == association.id,
                                    onSelect: { viewModel.selectedAssociationId = association.id }
                    )
                }
            }
            .listStyle(.plain)
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    store.associationId = viewModel.selectedAssociationId
                    onFilter()
                    dismiss()
                } label: {
                    Text("Done")
                        .fontWeight(.semibold)
                }
            }
        }
        .task { await viewModel.loadAssociations() }
        .task { viewModel.synchronizeEventsFilter(with: store.associationId)}
    }
}

struct EventsFilterView_Previews: PreviewProvider {
    static var previews: some View {
        EventsFilterView(onFilter: { })
            .environmentObject(EventsFilterStore())
            .environmentObject(EventsFilterViewModel())
    }
}
