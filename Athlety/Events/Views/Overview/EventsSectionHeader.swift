//
//  EventsSectionHeader.swift
//  Athlety
//
//  Created by Stefan Lipp on 25.08.25.
//

import SwiftUI

struct EventsSectionHeader: View {
    let date: Date

    var body: some View {
        Text(date.formatted(.dateTime.weekday(.wide).day(.twoDigits).month(.wide).year()))
            .font(.callout)
            .foregroundStyle(.primary)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
    }
}

#Preview {
    EventsSectionHeader(date: .now)
}
