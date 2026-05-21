//
//  SettingsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 03.01.26.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss

    @AppStorage("appAppearance") private var appAppearance: Appearance = .system

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
            .environment(\.defaultMinListRowHeight, 56)
            .scrollContentBackground(.visible)
            .toolbarTitleDisplayMode(.inline)
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
            .foregroundStyle(.primary)
            .fontWeight(.semibold)
            .padding(.bottom, 4)
    }

    // MARK: - Rows

    private var appearanceRow: some View {
        Picker(selection: $appAppearance) {
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

    private var languageRow: some View {
        Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
            Label("Language", systemImage: "globe.desk")
        }
    }

    private var tellFriendRow: some View {
        ShareLink(item: URL(string: "https://www.athlety.app")!) {
            Label("Tell a friend!", systemImage: "hand.thumbsup")
        }
    }

    private var rateAppRow: some View {
        Link(destination: URL(string: "https://apps.apple.com/app/id6761119486?action=write-review")!) {
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

    private var feedbackRow: some View {
        Link(destination: URL(string: "mailto:hello@athlety.app")!) {
            Label("Feedback & Support", systemImage: "questionmark.circle")
        }
    }
}

#Preview {
    SettingsView()
}
