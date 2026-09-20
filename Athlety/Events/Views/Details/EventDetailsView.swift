//
//  EventDetailsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftData
import SwiftUI

struct EventDetailsView: View {
    let eventId: Int

    @Environment(\.modelContext) private var modelContext

    @State private var viewModel = EventDetailsViewModel()

    var body: some View {
        List {
            if let event = viewModel.event {
                Section {
                    EventHeaderView(name: event.name, date: event.date, location: event.location.name)
                }
                .listSectionSeparator(.hidden)

                Section {
                    EventCalendarExportView(event: Event(event: event))
                    EventLinksView(url: event.url, links: event.links)
                    EventAttachmentsView(attachments: event.attachments)
                }
                .listSectionSeparator(.hidden)

                if event.isCancelled || event.note != nil {
                    Section {
                        EventNoteView(isCancelled: event.isCancelled, note: event.note)
                    }
                    .listSectionSeparator(event.isCancelled ? .hidden : .visible)
                }

                let disciplines = event.deduplicatedDisciplines
                if !disciplines.isEmpty {
                    Section {
                        EventDisciplineTagsView(disciplines: disciplines)
                    }
                    .listSectionSeparator(.hidden)
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
        .task(id: eventId) {
            await viewModel.loadEventDetails(for: eventId, with: modelContext)
        }
        .toolbar {
            EventDetailsToolbar(isSavedAsBookmark: viewModel.isSavedAsBookmark) {
                if viewModel.isSavedAsBookmark {
                    viewModel.removeEventFromBookmarks(in: modelContext)
                } else {
                    viewModel.saveEventAsBookmark(in: modelContext)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EventDetailsView(eventId: 44253)
    }
}
