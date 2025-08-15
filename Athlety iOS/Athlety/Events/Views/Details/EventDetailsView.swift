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
        ScrollView {
            if let event = viewModel.event {
                VStack(alignment: .leading) {
                    EventHeaderView(event: event)
                    Divider()
                }
                .padding(20)
            }
        }
        .task {
            await viewModel.loadEventDetails(for: eventId)
        }
    }
}

#Preview {
    NavigationStack {
        EventDetailsView(eventId: 44253)
            .environmentObject(EventDetailsViewModel())
    }
}
