//  EventDetailsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventDetailsView: View {
    let eventId: Int
    
    @EnvironmentObject private var viewModel: EventDetailsViewModel
    
    var body: some View {
        List {
            if let event = viewModel.event {
                
                Section {
                    EventHeaderView(event: event)
                }
                .listSectionSeparator(.hidden)
                
                Section {
                    EventAttachementsView(attachements: event.attachements)
                }
                .listSectionSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .task {
            await viewModel.loadEventDetails(for: eventId)
        }
        .onDisappear {
            viewModel.event = nil
        }
    }
}

#Preview {
    NavigationStack {
        EventDetailsView(eventId: 44253)
            .environmentObject(EventDetailsViewModel())
    }
}
