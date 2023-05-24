//
//  EventsFilterView.swift
//  Athlety
//
//  Created by Stefan Cimander on 19.05.23.
//

import SwiftUI

struct EventsFilterView: View {
    
    @EnvironmentObject var viewModel: EventsFilterViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.associations) { association in
                    Text(association.name)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Filter Events")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task { await viewModel.loadAssociations() }
    }
}

struct EventsFilterView_Previews: PreviewProvider {
    static var previews: some View {
        EventsFilterView()
            .environmentObject(EventsFilterViewModel())
    }
}
