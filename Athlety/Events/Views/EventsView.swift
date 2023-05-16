//
//  EventsView.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import SwiftUI

struct EventsView: View {
    
    @EnvironmentObject var viewModel: EventsViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.events) { event in
                Text(event.name)
            }
        }
        .task { await viewModel.loadUpcomingEvents() }
    }
}

struct EventsView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
            .environmentObject(EventsViewModel())
    }
}
