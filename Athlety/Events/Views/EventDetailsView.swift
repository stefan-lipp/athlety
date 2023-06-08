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
            Section {
                Text(viewModel.event?.name ?? "")
                    .font(.title)
                    .fontWeight(.medium)
                
                Text("\(date) at \(viewModel.event?.location ?? "")")
            }
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .task { await viewModel.loadEventDetails(for: eventId) }
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
