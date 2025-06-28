//
//  EventsOverview.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import SwiftUI

struct EventsOverview: View {
    
    @EnvironmentObject private var viewModel: EventsOverviewViewModel
    
    @State private var showFilter = false
    
    var body: some View {
        NavigationStack {
            EventsList(eventsByDate: viewModel.eventsByDate)
                .navigationTitle("Events")
                .toolbar { toolbar }
                .sheet(isPresented: $showFilter) {
                    EventsFilterView()
                }
        }
        .task {
            await viewModel.loadUpcomingEvents()
        }
    }
    
    private func sectionHeader(for date: Date) -> some View {
        Text(date.formatted(.dateTime.weekday(.wide).day(.twoDigits).month(.wide).year()))
            .font(.callout)
            .foregroundColor(.primary)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
    }
    
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                showFilter = true
            } label: {
                Label("Filter", systemImage: "line.3.horizontal.decrease")
            }
        }
    }
}

#Preview {
    EventsOverview()
        .environmentObject(EventsOverviewViewModel())
}
