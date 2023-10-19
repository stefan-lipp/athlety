//
//  EventDetailsView.swift
//  Athlety
//
//  Created by Stefan Cimander on 26.05.23.
//

import SwiftUI

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
                .padding(.bottom, 20)
            }
            
            if let attachements = viewModel.event?.attachements, !attachements.isEmpty {
                Section {
                    EventAttachementsView(attachements: attachements)
                }
                .listSectionSeparator(.visible)
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
        .task { await viewModel.loadEventDetails(for: eventId) }
        .onDisappear { viewModel.event = nil }
    }
    
    private var date: String {
        guard let event = viewModel.event else { return "" }
        return dateFormatter.string(from: event.date)
    }
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter
    }
}

struct EventDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EventDetailsView(eventId: 34388)
            .environmentObject(EventDetailsViewModel())
    }
}
