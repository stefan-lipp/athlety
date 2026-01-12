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
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    appearanceRow
                    languageRow
                } header: {
                    sectionHeader(for: "General")
                }
                .listSectionSeparator(.hidden)
                
                Section {
                    tellFriendRow
                    rateAppRow
                } header: {
                    sectionHeader(for: "Recommend")
                }
                .listSectionSeparator(.hidden)
                
                Section {
                    aboutAthletyRow
                    feedbackRow
                } header: {
                    sectionHeader(for: "Information")
                }
                .listSectionSeparator(.hidden)
            }
            .foregroundStyle(.primary)
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.defaultMinListRowHeight, 56)
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
    
    private func sectionHeader(for title: LocalizedStringKey) -> some View {
        Text(title)
            .font(.callout)
            .foregroundColor(.primary)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
    }
    
    // MARK: - Rows
    
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
    }
    
    @ViewBuilder
    private var languageRow: some View {
        let appSettingsUrl = URL(string: UIApplication.openSettingsURLString)!
        Link(destination: appSettingsUrl) {
            Label("Language", systemImage: "globe.desk")
        }
    }
    
    @ViewBuilder
    private var tellFriendRow: some View {
        let websiteUrl = URL(string: "https://www.athlety.app")!
        ShareLink(item: websiteUrl) {
            Label("Tell a friend!", systemImage: "hand.thumbsup")
        }
    }
    
    @ViewBuilder
    private var rateAppRow: some View {
        // TODO: Provide correct App ID for review URL
        let reviewUrl = URL(string: "https://apps.apple.com/app/<AppId>?action=write-review")!
        Link(destination: reviewUrl) {
            Label("Rate the App", systemImage: "star")
        }
    }
    
    private var aboutAthletyRow: some View {
        NavigationLink {
            AboutView()
        } label: {
            Label("About Athlety", systemImage: "info.circle")
        }
    }
    
    @ViewBuilder
    private var feedbackRow: some View {
        let url = URL(string: "mailto:hello@athlety.app")!
        Link(destination: url) {
            Label("Feedback & Support", systemImage: "questionmark.circle")
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsStore())
}
