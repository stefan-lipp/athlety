//
//  EventsPlaceholderView.swift
//  Athlety
//
//  Created by Stefan Lipp on 14.09.26.
//

import SwiftUI

struct EventsPlaceholderView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let icon: String
    let title: LocalizedStringKey
    let description: LocalizedStringKey

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundStyle(.accent)
            Text(title)
                .font(.title2)
                .fontWeight(.medium)
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .padding()
        .toolbar {
            if horizontalSizeClass != .compact {
                SettingsToolbarButton()
            }
        }
    }
}

#Preview {
    EventsPlaceholderView(
        icon: "square.stack",
        title: "No Events Found",
        description: "Try changing your filter options to see upcoming events."
    )
    .padding()
}
