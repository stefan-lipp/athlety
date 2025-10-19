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
    let onSaveAsBookmark: (Event) -> Void
    let onRemoveFromBookmarks: (Event) -> Void

    private var eventsByDate: [Date: [Event]] {
        let events = selectedCategory == .upcoming ? upcomingEvents : savedEvents
        return Dictionary(grouping: events, by: { $0.date })
    }

    @EnvironmentObject private var calendarEventViewModel: CalendarEventViewModel
    
    @State private var showCalendarEventEditView = false

    var body: some View {
        List {
            Section {
                categorySelectionRow
            }
            if selectedCategory == .saved && savedEvents.isEmpty {
                Section {
                    emptyStateRow
                }
            } else {
                ForEach(eventsByDate.keys.sorted(by: <), id: \.self) { date in
                    Section {
                        eventRows(for: date)
                    } header: {
                        sectionHeader(for: date)
                    }
                }
                .navigationLinkIndicatorVisibility(.hidden)
            }
        }
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
                Image(systemName: "bookmark")
                    .font(.largeTitle)
                    .foregroundStyle(.accent)
                Text("No Saved Events")
                    .font(.title2)
                    .fontWeight(.medium)
                Text("Save events you're interested in to see them here.")
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
        HStack {
            Image(systemName: category.icon).symbolVariant(.fill)
            if selectedCategory == category {
                Text(category.title)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .frame(minWidth: 64, minHeight: 40)
        .foregroundStyle(selectedCategory == category ? .white : .secondary)
        .background(selectedCategory == category ? .accent : Color(UIColor.secondarySystemGroupedBackground))
        .clipShape(Capsule())
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.bouncy) {
                selectedCategory = category
            }
        }
    }

    private func eventRows(for date: Date) -> some View {
        ForEach(eventsByDate[date]!) { event in
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

    private func sectionHeader(for date: Date) -> some View {
        Text(date.formatted(.dateTime.weekday(.wide).day(.twoDigits).month(.wide).year()))
            .font(.callout)
            .foregroundColor(.primary)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
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

#Preview {
    let event = Event(id: 44253, name: "36. Rheinfelder Nachtmeeting", location: "Rheinfelden", date: Date())
    EventsList(
        selectedCategory: .constant(.saved),
        upcomingEvents: [event],
        savedEvents: [],
        onSaveAsBookmark: { _ in },
        onRemoveFromBookmarks: { _ in }
    )
    .environmentObject(CalendarEventViewModel())
}
