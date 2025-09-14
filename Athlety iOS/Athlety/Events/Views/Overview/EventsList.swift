//
//  EventsList.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsList: View {
    let eventsByDate: [Date: [Event]]
    let eventBookmars: [EventBookmark]
    let onSave: (Event) -> Void
    
    var body: some View {
        List {
            Section {
                NavigationLink(destination: EventBookmarksView()) {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "bookmark.fill")
                                .font(.title2)
                                .fontWeight(.bold)
                            Spacer()
                            Text(verbatim: "\(eventBookmars.count)")
                                .font(.title)
                                .fontWeight(.heavy)
                        }
                        .padding(.bottom, 4)
                        
                        Text("Saved Events")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                }
                .listRowBackground(Rectangle().foregroundStyle(
                    LinearGradient(
                        colors: [.accent, .accent.opacity(0.7)],
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    )
                ))
                .navigationLinkIndicatorVisibility(.hidden)
            }

            ForEach(eventsByDate.keys.sorted(by: <), id: \.self) { date in
                Section {
                    ForEach(eventsByDate[date]!) { event in
                        NavigationLink(destination: EventDetailsView(eventId: event.id)) {
                            let isSaved = eventBookmars.map(\.id).contains(event.id)
                            EventRow(event: event, isSaved: isSaved)
                        }
                        .contextMenu {
                            Button {
                                onSave(event)
                            } label: {
                                Label("Save as Bookmark", systemImage: "bookmark")
                            }
                        }
                    }
                } header: {
                    sectionHeader(for: date)
                }
            }
            .navigationLinkIndicatorVisibility(.hidden)
        }
        .listRowSpacing(8)
    }
    
    private func sectionHeader(for date: Date) -> some View {
        Text(date.formatted(.dateTime.weekday(.wide).day(.twoDigits).month(.wide).year()))
            .font(.callout)
            .foregroundColor(.primary)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
    }
}

#Preview {
    let event = Event(id: 44253, name: "36. Rheinfelder Nachtmeeting", location: "Rheinfelden", date: Date())
    EventsList(eventsByDate: [event.date: [event]], eventBookmars: []) { _ in }
}
