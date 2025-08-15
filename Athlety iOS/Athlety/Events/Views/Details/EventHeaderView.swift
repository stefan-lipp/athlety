//
//  EventHeaderView.swift
//  Athlety
//
//  Created by Stefan Lipp on 11.07.25.
//

import SwiftUI

struct EventHeaderView: View {
    let event: EventDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(event.name)
                .font(.title)
                .fontWeight(.semibold)
            Text("\(formattedDate) in \(event.location.name)")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var formattedDate: String {
        event.date.formatted(.dateTime.weekday(.wide).day().month(.wide).year())
    }
}
