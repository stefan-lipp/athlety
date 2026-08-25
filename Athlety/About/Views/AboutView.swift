//
//  AboutView.swift
//  Athlety
//
//  Created by Stefan Lipp on 05.01.26.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack {
                appIcon
                title
                subtitle
                versionText
                websiteLink
                aboutText
                copyright
            }
        }
    }

    private var appIcon: some View {
        Image(.athletyAppIcon)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: 84)
    }

    private var title: some View {
        Text("Athlety")
            .font(.largeTitle)
            .fontWeight(.semibold)
    }

    private var subtitle: some View {
        Text("Track & Field Planner")
            .font(.title3)
            .fontWeight(.medium)
    }

    private var websiteLink: some View {
        Link("www.athlety.app", destination: URL(string: "https://www.athlety.app")!)
            .padding(.top)
    }

    private var versionText: some View {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "—"
        return Text("v\(version)")
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }

    private var aboutText: some View {
        let description: LocalizedStringKey = """
        Athlety is an app for track and field athletes, coaches, and anyone interested in athletics in Germany.

        The app provides an overview of upcoming competitions and events and allows you to save important dates for quick access. \
        It is designed to help you stay organized throughout the athletics season.

        Athlety is developed and published by Stefan Lipp in Regensburg, Germany. \
        Your feedback and suggestions are always welcome and help improve the app.
        """

        return Text(description)
            .font(.body)
            .padding(20)
    }

    private var copyright: some View {
        Text("Copyright © 2026 Stefan Lipp.")
            .font(.footnote)
            .foregroundStyle(.secondary)
            .padding(.vertical)
    }
}

#Preview {
    AboutView()
}
