//
//  EventsList.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsList: View {
    @Binding var selectedCategory: EventsOverviewCategory
    @Binding var selectedEventId: Int?

    let upcomingEvents: [Event]
    let savedEvents: [Event]
    let isLoadingUpcomingEvents: Bool
    let onSaveAsBookmark: (Event) -> Void
    let onRemoveFromBookmarks: (Event) -> Void

    private var sortedEventGroups: [(date: Date, events: [Event])] {
        let events = selectedCategory == .upcoming ? upcomingEvents : savedEvents
        return Dictionary(grouping: events, by: \.date)
            .map { (date: $0.key, events: $0.value) }
            .sorted { $0.date < $1.date }
    }

    private var savedEventIds: Set<Int> {
        Set(savedEvents.map(\.id))
    }

    private var showLoadingRows: Bool {
        selectedCategory == .upcoming && isLoadingUpcomingEvents
    }

    private var showEmptyStateRow: Bool {
        selectedCategory == .upcoming && upcomingEvents.isEmpty ||
            selectedCategory == .saved && savedEvents.isEmpty
    }

    @Environment(CalendarEventViewModel.self) private var calendarEventViewModel

    @State private var showCalendarEventEditView = false

    var body: some View {
        List(selection: $selectedEventId) {
            Section {
                EventsCategorySelection(selectedCategory: $selectedCategory)
            }
            .selectionDisabled()
            if showLoadingRows {
                EventsLoadingRows()
                    .selectionDisabled()
                    .transition(.opacity)
            } else if showEmptyStateRow {
                Section {
                    emptyStateRow
                }
                .selectionDisabled()
                .transition(.opacity)
            } else {
                ForEach(sortedEventGroups, id: \.date) { group in
                    Section {
                        eventRows(for: group.events)
                    } header: {
                        EventsSectionHeader(date: group.date)
                    }
                }
                .transition(.opacity)
            }
        }
        .animation(.easeInOut, value: showLoadingRows)
        .sheet(isPresented: $showCalendarEventEditView, content: {
            CalendarEventEditView(
                event: calendarEventViewModel.calendarEvent,
                eventStore: calendarEventViewModel.calendarEventStore
            )
        })
        .listRowSpacing(8)
        .scrollContentBackground(.hidden)
    }

    private var emptyStateRow: some View {
        HStack {
            Spacer()
            EventsPlaceholderView(
                icon: selectedCategory.icon,
                title: selectedCategory == .upcoming ? "No Events Found" : "No Saved Events",
                description: selectedCategory == .upcoming
                    ? "Try changing your filter options to see upcoming events."
                    : "Save events you're interested in to see them here."
            )
            Spacer()
        }
        .padding(.top, 40)
        .listRowBackground(EmptyView())
        .listRowInsets(.init())
    }

    private func eventRows(for events: [Event]) -> some View {
        ForEach(events) { event in
            let isSaved = savedEventIds.contains(event.id)
            let isSelected = event.id == selectedEventId
            EventRow(event: event, isSaved: isSaved, isSelected: isSelected)
                .tag(event.id)
                .selectionDisabled()
                .contentShape(.rect)
                .onTapGesture { selectedEventId = event.id }
                .contextMenu {
                    saveOrUnsaveButton(for: event)
                    addToCalendarButton(for: event)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    saveOrUnsaveButton(for: event)
                        .tint(isSaved ? .accent : .blue)
                }
        }
    }

    private func saveOrUnsaveButton(for event: Event) -> some View {
        let isSaved = savedEventIds.contains(event.id)
        let action = isSaved ? onRemoveFromBookmarks : onSaveAsBookmark
        let title: LocalizedStringKey = isSaved ? "Remove Bookmark" : "Save as Bookmark"
        let image = isSaved ? "bookmark.slash" : "bookmark"

        return Button { action(event) } label: {
            Label(title, systemImage: image)
        }
    }

    private func addToCalendarButton(for event: Event) -> some View {
        Button {
            calendarEventViewModel.addEventToCalendar(event)
            showCalendarEventEditView = true
        } label: {
            Label("Add to Calendar", systemImage: "calendar.badge.plus")
        }
    }
}

#Preview("Loaded") {
    @Previewable @State var selectedCategory: EventsOverviewCategory = .upcoming
    @Previewable @State var selectedEventId: Int?
    let event = Event(id: 44253, name: "36. Rheinfelder Nachtmeeting", location: "Rheinfelden", date: Date(), isCancelled: false)
    EventsList(
        selectedCategory: $selectedCategory,
        selectedEventId: $selectedEventId,
        upcomingEvents: [event],
        savedEvents: [],
        isLoadingUpcomingEvents: false,
        onSaveAsBookmark: { _ in },
        onRemoveFromBookmarks: { _ in }
    )
    .environment(CalendarEventViewModel())
}

#Preview("Loading") {
    @Previewable @State var selectedCategory: EventsOverviewCategory = .upcoming
    @Previewable @State var selectedEventId: Int?
    EventsList(
        selectedCategory: $selectedCategory,
        selectedEventId: $selectedEventId,
        upcomingEvents: [],
        savedEvents: [],
        isLoadingUpcomingEvents: true,
        onSaveAsBookmark: { _ in },
        onRemoveFromBookmarks: { _ in }
    )
    .environment(CalendarEventViewModel())
}
