//
//  EventsOverview.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsOverview: View {
    
    @EnvironmentObject var viewModel: EventsOverviewViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.events) { event in
                EventRow(event: event)
            }
        }
        .task {
            await viewModel.loadUpcomingEvents()
        }
    }
}

#Preview {
    EventsOverview()
        .environmentObject(EventsOverviewViewModel())
}
