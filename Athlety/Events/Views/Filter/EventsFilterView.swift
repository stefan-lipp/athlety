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
    
    var body: some View {
        NavigationStack {
            List {
                filterRows
            }
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.defaultMinListRowHeight, 56)
            .toolbar { toolbar }
        }
        .task {
            await viewModel.loadAssociations()
            selectedAssociationId = viewModel.eventsFilterAssociationId
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
                dismiss()
            }
        }
    }
    
    @ViewBuilder
    private var filterRows: some View {
        EventsFilterRow(
            name: "All",
            isSelected: selectedAssociationId == nil,
            onSelect: { selectedAssociationId = nil }
        )
        
        ForEach(viewModel.associations) { association in
            EventsFilterRow(
                name: LocalizedStringKey(association.name),
                isSelected: selectedAssociationId == association.id,
                onSelect: { selectedAssociationId = association.id }
            )
        }
    }
}

#Preview {
    EventsFilterView()
        .environmentObject(EventsFilterViewModel())
}
