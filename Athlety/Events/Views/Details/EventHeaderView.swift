//
//  EventHeaderView.swift
//  Athlety
//
//  Created by Stefan Lipp on 11.07.25.
//

import SwiftUI

struct EventHeaderView: View {
    let name: String
    let date: Date
    let location: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(name)
                .font(.title)
                .fontWeight(.medium)
            Text("\(formattedDate) in \(location)")
                .font(.headline)
                .foregroundStyle(.secondary)
        }
    }
    
    private var formattedDate: String {
        date.formatted(.dateTime.weekday(.wide).day().month(.wide).year())
    }
}

#Preview {
    let date = Date(timeIntervalSince1970: 1753999200)
    EventHeaderView(name: "36. Rheinfelder Nachtmeeting ~ Die Finale Blaue Nacht ~", date: date, location: "Rheinfelden")
        .padding()
}
