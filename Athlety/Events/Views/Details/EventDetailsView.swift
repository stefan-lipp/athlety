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
                    VStack(alignment: .leading, spacing: 16) {
                        Text(event.name)
                            .fontWeight(.medium)
                            .font(.title)
                        
                        Text("\(date) at \(event.location.name)")
                            .foregroundStyle(.secondary)
                    }
                }
                .listSectionSeparator(.hidden)
                .listSectionSpacing(.custom(20))
                
                Section {
                    EventCalendarExportView()
                }
                .listSectionSeparator(.hidden)
            }
            if let attachements = viewModel.event?.attachements, !attachements.isEmpty {
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
    
    private var date: String {
        guard let event = viewModel.event else { return "" }
        return event.date.formatted(.dateTime.weekday(.wide).day().month(.wide).year())
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(eventId: 34388)
            .environmentObject(EventDetailsViewModel())
    }
}
