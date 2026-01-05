//  EventDetailsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventDetailsView: View {
    let eventId: Int
    
    @Environment(\.modelContext) private var modelContext
    
    @EnvironmentObject private var viewModel: EventDetailsViewModel
    
    var body: some View {
        List {
            if let event = viewModel.event {
                Section {
                    EventHeaderView(name: event.name, date: event.date, location: event.location.name)
                }
                .listSectionSeparator(.hidden)
                
                Section {
                    EventCalendarExportView(event: event)
                    EventLinksView(links: event.links)
                    EventAttachementsView(attachements: event.attachements)
                }
                .listSectionSeparator(.hidden)
                
                if let note = event.note {
                    Section {
                        EventNoteView(note: note)
                    }
                }
                
                Section {
                    EventLocationView(location: event.location)
                }
                
                Section {
                    EventRegistrationView(registration: event.registration)
                }
                .listSectionSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .task {
            await viewModel.loadEventDetails(for: eventId, with: modelContext)
        }
        .onDisappear {
            viewModel.resetEventDetails()
        }
        .toolbar {
            toolbar
        }
    }
    
    private var toolbar: some ToolbarContent {
        ToolbarItem {
            Button {
                if viewModel.isSavedAsBookmark {
                    viewModel.removeEventFromBookmarks(in: modelContext)
                } else {
                    viewModel.saveEventAsBookmark(in: modelContext)
                }
            } label: {
                Image(systemName: "bookmark")
                    .symbolVariant(viewModel.isSavedAsBookmark ? .fill : .none)
                    .foregroundStyle(viewModel.isSavedAsBookmark ? .accent : .primary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        EventDetailsView(eventId: 44253)
            .environmentObject(EventDetailsViewModel())
    }
}
