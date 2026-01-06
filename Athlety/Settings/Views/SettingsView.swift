//
//  SettingsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 03.01.26.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var settingsStore: SettingsStore
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ListSectionHeader(title: "General")
                    appearanceRow
                }
                .listSectionSeparator(.hidden)
                
                Section {
                    ListSectionHeader(title: "Recommend")
                    tellFriendRow
                    rateAppRow
                }
                .listSectionSeparator(.hidden)
                
                Section {
                    ListSectionHeader(title: "Information")
                    aboutAthletyRow
                    feedbackRow
                }
                .listSectionSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.visible)
            .toolbar { toolbar }
        }
    }
    
    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button("Cancel", systemImage: "xmark") {
                dismiss()
            }
        }
    }
    
    private var appearanceRow: some View {
        Picker(selection: $settingsStore.appAppearance) {
            ForEach(Appearance.allCases) { appearance in
                Text(appearance.localized)
                    .tag(appearance)
            }
        } label: {
            Label("Appearance", systemImage: "sun.max")
        }
        .pickerStyle(.menu)
        .menuIndicator(.hidden)
        .buttonStyle(.bordered)
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private var tellFriendRow: some View {
        let websiteUrl = URL(string: "https://www.athlety.app")!
        ShareLink(item: websiteUrl) {
            Label("Tell a friend!", systemImage: "hand.thumbsup")
        }
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private var rateAppRow: some View {
        // TODO: Provide correct App ID for review URL
        let reviewUrl = URL(string: "https://apps.apple.com/app/<AppId>?action=write-review")!
        Link(destination: reviewUrl) {
            Label("Rate the App", systemImage: "star")
        }
        .padding(.vertical, 8)
    }
    
    private var aboutAthletyRow: some View {
        NavigationLink {
            AboutView()
        } label: {
            Label("About Athlety", systemImage: "info.circle")
        }
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private var feedbackRow: some View {
        let url = URL(string: "mailto:hello@athlety.app")!
        Link(destination: url) {
            Label("Feedback & Support", systemImage: "questionmark.circle")
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsStore())
}
