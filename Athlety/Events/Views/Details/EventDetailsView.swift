//
//  EventDetailsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftData
import SwiftUI
import TipKit

struct EventDetailsView: View {
    let eventId: Int

    @Environment(\.modelContext) private var modelContext

    @State private var viewModel = EventDetailsViewModel()

    @Query private var eventBookmarks: [EventBookmark]

    private let bookmarkTip = BookmarkTip()

    private var isSavedAsBookmark: Bool {
        !eventBookmarks.isEmpty
    }

    init(eventId: Int) {
        self.eventId = eventId
        _eventBookmarks = Query(filter: #Predicate<EventBookmark> { $0.id == eventId })
    }

    var body: some View {
        List {
            Group {
                if let event = viewModel.event {
                    TipView(bookmarkTip)
                        .listRowSeparator(.hidden)

                    Section {
                        EventHeaderView(name: event.name, date: event.date, location: event.location.name)
                        #if os(macOS)
                            .padding(.bottom)
                            .listRowSeparator(.hidden)
                        #endif
                    }
                    .listSectionSeparator(.hidden)

                    Section {
                        #if os(iOS)
                            EventCalendarExportView(event: Event(event: event))
                        #endif
                        EventLinksView(url: event.url, links: event.links)
                        EventAttachmentsView(attachments: event.attachments)
                        EventResultsView(results: event.results)
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
                            #if os(macOS)
                                .listRowSeparator(.hidden)
                            #endif
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
            #if os(macOS)
            .listRowInsets(.horizontal, 16)
            #endif
        }
        .listStyle(.plain)
        .task(id: eventId) {
            await viewModel.loadEventDetails(for: eventId)
        }
        .toolbar {
            EventDetailsToolbar(isSavedAsBookmark: isSavedAsBookmark, onToggleBookmark: toggleBookmark)
        }
    }

    private func toggleBookmark() {
        if isSavedAsBookmark {
            eventBookmarks.forEach(modelContext.delete)
        } else if let event = viewModel.event {
            modelContext.insert(EventBookmark(event: event))
            bookmarkTip.invalidate(reason: .actionPerformed)
        }
    }
}

#Preview {
    NavigationStack {
        EventDetailsView(eventId: 44253)
    }
}
