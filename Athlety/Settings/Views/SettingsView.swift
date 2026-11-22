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
            settingsContent
                .navigationTitle("Settings")
                .toolbarTitleDisplayMode(.inline)
                .toolbar { toolbar }
        }
        #if os(macOS)
        .frame(minWidth: 420, idealWidth: 440, maxWidth: 600, minHeight: 480, idealHeight: 520, maxHeight: 600)
        .presentationSizing(.fitted)
        #endif
    }

    #if os(macOS)
        private var settingsContent: some View {
            Form {
                sections
            }
            .formStyle(.grouped)
            .foregroundStyle(.primary)
        }
    #else
        private var settingsContent: some View {
            List {
                sections
            }
            .foregroundStyle(.primary)
            .listStyle(.insetGrouped)
            .environment(\.defaultMinListRowHeight, 56)
            .scrollContentBackground(.visible)
        }
    #endif

    @ViewBuilder
    private var sections: some View {
        Section {
            appearanceRow
            #if os(iOS)
                languageRow
            #endif
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

    @ToolbarContentBuilder
    private var toolbar: some ToolbarContent {
        #if os(macOS)
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    dismiss()
                }
            }
        #else
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", systemImage: "xmark") {
                    dismiss()
                }
            }
        #endif
    }

    #if os(macOS)
        private func sectionHeader(for title: LocalizedStringKey) -> some View {
            Text(title)
        }
    #else
        private func sectionHeader(for title: LocalizedStringKey) -> some View {
            Text(title)
                .font(.callout)
                .foregroundStyle(.primary)
                .fontWeight(.semibold)
                .padding(.bottom, 4)
        }
    #endif

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
        #if os(macOS)
            .settingsRowPadding()
        #else
            .menuIndicator(.hidden)
            .buttonStyle(.bordered)
        #endif
    }

    #if os(iOS)
        private var languageRow: some View {
            Link(destination: URL(string: UIApplication.openSettingsURLString)!) {
                Label("Language", systemImage: "globe.desk")
            }
        }
    #endif

    private var tellFriendRow: some View {
        ShareLink(item: URL(string: "https://www.athlety.app")!) {
            Label("Tell a friend!", systemImage: "hand.thumbsup")
        }
        #if os(macOS)
        .buttonStyle(.plain)
        #endif
        .settingsRowPadding()
    }

    private var rateAppRow: some View {
        Link(destination: URL(string: "https://apps.apple.com/app/id6761119486?action=write-review")!) {
            Label("Rate the App", systemImage: "star")
        }
        .settingsRowPadding()
    }

    private var aboutAthletyRow: some View {
        NavigationLink {
            AboutView()
        } label: {
            Label("About Athlety", systemImage: "info.circle")
        }
        .settingsRowPadding()
    }

    private var feedbackRow: some View {
        Link(destination: URL(string: "mailto:hello@athlety.app")!) {
            Label("Feedback & Support", systemImage: "questionmark.circle")
        }
        .settingsRowPadding()
    }
}

private extension View {
    func settingsRowPadding() -> some View {
        #if os(macOS)
            padding(.vertical, 4)
        #else
            self
        #endif
    }
}

#Preview {
    SettingsView()
}
