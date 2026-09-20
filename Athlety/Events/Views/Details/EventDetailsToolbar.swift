//
//  EventDetailsToolbar.swift
//  Athlety
//
//  Created by Stefan Lipp on 20.09.26.
//

import SwiftUI

struct EventDetailsToolbar: ToolbarContent {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let isSavedAsBookmark: Bool
    let onToggleBookmark: () -> Void

    var body: some ToolbarContent {
        ToolbarItem {
            Button(action: onToggleBookmark) {
                Image(systemName: "bookmark")
                    .symbolVariant(isSavedAsBookmark ? .fill : .none)
                    .foregroundStyle(isSavedAsBookmark ? .accent : .primary)
            }
        }
        if horizontalSizeClass != .compact {
            ToolbarSpacer()
            SettingsToolbarButton()
        }
    }
}
