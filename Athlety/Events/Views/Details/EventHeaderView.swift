//
//  EventHeaderView.swift
//  Athlety
//
//  Created by Stefan Lipp on 09.04.24.
//

import SwiftUI

struct EventHeaderView: View {
    
    let event: EventDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(event.name)
                .fontWeight(.medium)
                .font(.title)
            
            Text("\(formattedDate) at \(event.location.name)")
                .foregroundStyle(.secondary)
        }
    }
    
    private var formattedDate: String {
        event.date.formatted(.dateTime.weekday(.wide).day().month(.wide).year())
    }
}
