//
//  SettingsToolbarButton.swift
//  Athlety
//
//  Created by Stefan Lipp on 20.09.26.
//

import SwiftUI

struct SettingsToolbarButton: ToolbarContent {
    @Environment(\.colorScheme) private var colorScheme

    @State private var showSettings = false

    var body: some ToolbarContent {
        ToolbarItem {
            Button {
                showSettings = true
            } label: {
                Label("Settings", systemImage: "gearshape")
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .preferredColorScheme(colorScheme)
            }
        }
    }
}
