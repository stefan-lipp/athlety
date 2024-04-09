//
//  EventDetailsView.swift
//  Athlety
//
//  Created by Stefan Cimander on 26.05.23.
//

import SwiftUI
import EventKitUI

struct EventDetailsView: View {
    
    let eventId: Int
    
    @EnvironmentObject var viewModel: EventDetailsViewModel
    
    var body: some View {
        List {
            if let event = viewModel.event {
                Section {
                    EventHeaderView(event: event)
                }
                .listSectionSeparator(.hidden)
                .listSectionSpacing(.custom(20))
                
                Section {
                    EventCalendarExportView()
                }
                .listSectionSeparator(attachements.isEmpty ? .hidden : .automatic)
            }
            if !attachements.isEmpty {
                Section {
                    EventAttachementsView(attachements: attachements)
                }
                .listSectionSeparator(.hidden)
            }
            if let location = viewModel.event?.location {
                Section {
                    EventLocationView(location: location)
                }
                .listSectionSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.bottom, 20)
        .task { await viewModel.loadEventDetails(for: eventId) }
        .onDisappear { viewModel.event = nil }
    }
    
    private var attachements: [Attachement] {
        viewModel.event?.attachements ?? []
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(eventId: 34388)
            .environmentObject(EventDetailsViewModel())
    }
}
