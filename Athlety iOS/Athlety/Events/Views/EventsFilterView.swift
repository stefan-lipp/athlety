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
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.associations) { association in
                    Text(association.name)
                }
            }
            .navigationTitle("Filter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbar }
        }
        .task {
            await viewModel.loadAssociations()
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
                dismiss()
            }
        }
    }
}

#Preview {
    EventsFilterView()
        .environmentObject(EventsFilterViewModel())
}
