//
//  EventsList.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsList: View {
    @Binding var selectedCategory: EventsOverviewCategory

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
        List {
            Section {
                categorySelectionRow
            }
            if showLoadingRows {
                EventsLoadingRows()
                    .transition(.opacity)
            } else if showEmptyStateRow {
                Section {
                    emptyStateRow
                }
                .transition(.opacity)
            } else {
                ForEach(sortedEventGroups, id: \.date) { group in
                    Section {
                        eventRows(for: group.events)
                    } header: {
                        EventsSectionHeader(date: group.date)
                    }
                }
                .navigationLinkIndicatorVisibility(.hidden)
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
    }

    private var emptyStateRow: some View {
        HStack {
            Spacer()
            VStack(alignment: .center, spacing: 20) {
                Image(systemName: selectedCategory.icon)
                    .font(.largeTitle)
                    .foregroundStyle(.accent)
                Text(selectedCategory == .upcoming ? "No Events Found" : "No Saved Events")
                    .font(.title2)
                    .fontWeight(.medium)

                let description: LocalizedStringKey = selectedCategory == .upcoming
                    ? "Try changing your filter options to see upcoming events."
                    : "Save events you're interested in to see them here."
                Text(description)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.top, 40)
        .listRowBackground(EmptyView())
        .listRowInsets(.init())
    }

    private var categorySelectionRow: some View {
        HStack(spacing: 12) {
            categorySelection(for: .upcoming)
            categorySelection(for: .saved)
        }
        .font(.headline)
        .listRowBackground(EmptyView())
        .listRowInsets(.leading, 0)
    }

    private func categorySelection(for category: EventsOverviewCategory) -> some View {
        let isSelected = selectedCategory == category
        return Button {
            withAnimation(.bouncy) {
                selectedCategory = category
            }
        } label: {
            HStack {
                Image(systemName: category.icon).symbolVariant(.fill)
                if isSelected {
                    Text(category.title)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .frame(minWidth: 64, minHeight: 40)
            .foregroundStyle(isSelected ? .white : .secondary)
            .background(isSelected ? Color.accentColor : Color(.secondarySystemGroupedBackground))
            .clipShape(Capsule())
            .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(category.title)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private func eventRows(for events: [Event]) -> some View {
        ForEach(events) { event in
            let isSaved = savedEvents.map(\.id).contains(event.id)
            NavigationLink(destination: EventDetailsView(eventId: event.id)) {
                EventRow(event: event, isSaved: isSaved)
            }
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
        let isSaved = savedEvents.map(\.id).contains(event.id)
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
    let event = Event(id: 44253, name: "36. Rheinfelder Nachtmeeting", location: "Rheinfelden", date: Date(), isCancelled: false)
    EventsList(
        selectedCategory: $selectedCategory,
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
    EventsList(
        selectedCategory: $selectedCategory,
        upcomingEvents: [],
        savedEvents: [],
        isLoadingUpcomingEvents: true,
        onSaveAsBookmark: { _ in },
        onRemoveFromBookmarks: { _ in }
    )
    .environment(CalendarEventViewModel())
}
