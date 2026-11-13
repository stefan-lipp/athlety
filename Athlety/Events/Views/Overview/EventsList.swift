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
    var passedEvents: [Event] = []
    let savedEvents: [Event]
    let isLoadingUpcomingEvents: Bool
    var isLoadingPassedEvents = false
    let onSaveAsBookmark: (Event) -> Void
    let onRemoveFromBookmarks: (Event) -> Void
    var showsDisclosureIndicator = true

    private var events: [Event] {
        switch selectedCategory {
        case .upcoming: upcomingEvents
        case .passed: passedEvents
        case .saved: savedEvents
        }
    }

    /// Groups by date, with the most recent passed events first and the soonest otherwise.
    private var sortedEventGroups: [(date: Date, events: [Event])] {
        let isAscending = selectedCategory != .passed
        return Dictionary(grouping: events, by: \.date)
            .map { (date: $0.key, events: $0.value) }
            .sorted { isAscending ? $0.date < $1.date : $0.date > $1.date }
    }

    private var savedEventIds: Set<Int> {
        Set(savedEvents.map(\.id))
    }

    private var showLoadingRows: Bool {
        switch selectedCategory {
        case .upcoming: isLoadingUpcomingEvents
        case .passed: isLoadingPassedEvents
        case .saved: false
        }
    }

    private var showEmptyStateRow: Bool {
        events.isEmpty
    }

    private var emptyStateTitle: LocalizedStringKey {
        switch selectedCategory {
        case .upcoming: "No Events Found"
        case .passed: "No Passed Events"
        case .saved: "No Saved Events"
        }
    }

    private var emptyStateDescription: LocalizedStringKey {
        switch selectedCategory {
        case .upcoming: "Try changing your filter options to see upcoming events."
        case .passed: "Try changing your filter options to see passed events."
        case .saved: "Save events you're interested in to see them here."
        }
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
                EventsLoadingRows(showsDisclosureIndicator: showsDisclosureIndicator && selectedCategory != .passed)
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
                        if selectedCategory == .passed {
                            passedEventRows(for: group.events)
                        } else {
                            eventRows(for: group.events)
                        }
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
                title: emptyStateTitle,
                description: emptyStateDescription
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
            EventRow(
                event: event,
                isSaved: isSaved,
                isSelected: isSelected,
                showsDisclosureIndicator: showsDisclosureIndicator
            )
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

    /// Passed events come from a different LADV endpoint whose ids can't be used for event
    /// details or bookmarks, so their rows are display-only for now.
    private func passedEventRows(for events: [Event]) -> some View {
        ForEach(events) { event in
            EventRow(event: event, isSaved: false, isSelected: false, showsDisclosureIndicator: false)
                .selectionDisabled()
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
