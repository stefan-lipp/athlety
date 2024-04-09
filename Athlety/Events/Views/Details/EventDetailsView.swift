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
            }
            if let event = viewModel.event {                
                Section {
                    EventRegistrationView(registration: event.registration)
                } header: {
                    Text("Registration")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.bottom, 8)
                        .foregroundStyle(.primary)
                }
                .listSectionSeparator(.hidden)
            }
            
            Color.clear
                .frame(height: 0)
                .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
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
