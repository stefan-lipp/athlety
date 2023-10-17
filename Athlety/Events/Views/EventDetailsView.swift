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
                VStack(alignment: .leading, spacing: 20) {
                    Text(viewModel.event?.name ?? "")
                        .font(.title)
                        .fontWeight(.medium)
                    
                    Text("\(date) at \(viewModel.event?.location.name ?? "")")
                }
            }
            .listSectionSeparator(.hidden)
            .padding(.bottom, 20)
            
            if !(viewModel.event?.attachements.isEmpty ?? true) {
                Section {
                    ForEach(viewModel.event!.attachements, id: \.name) { attachement in
                        NavigationLink {
                            AttachementPDFView(url: attachement.url)
                                .navigationTitle(attachement.name)
                        } label: {
                            Label(attachement.name, systemImage: "doc")
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listSectionSeparator(.visible)
            }
            
            Section {
                if let location = viewModel.event?.location {
                    EventMapView(latitude: location.latitude, longitude: location.longitude)
                        .frame(height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                }
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
