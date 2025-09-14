//
//  EventBookmarksView.swift
//  Athlety
//
//  Created by Stefan Lipp on 11.09.25.
//

import SwiftData
import SwiftUI

struct EventBookmarksView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var eventBookmarks: [EventBookmark]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(eventBookmarks) { eventBookmark in
                    VStack(alignment: .leading) {
                        Text(eventBookmark.name)
                            .font(.headline)
                        
                        Text(eventBookmark.date.formatted(date: .long, time: .omitted))
                    }
                }
                .onDelete(perform: deleteEventBookmarks)
            }
            .navigationTitle("Saved Events")
        }
    }
    
    private func deleteEventBookmarks(_ indexSet: IndexSet) {
        for index in indexSet {
            let eventBookmark = eventBookmarks[index]
            modelContext.delete(eventBookmark)
        }
    }
}

#Preview {
    EventBookmarksView()
}
