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
                webisteLink
                aboutText
                copyright
            }
        }
    }
    
    private var appIcon: some View {
        Image("AthletyAppIcon")
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
        Text("Track & Field Events")
            .font(.title3)
            .fontWeight(.medium)
    }
    
    @ViewBuilder
    private var webisteLink: some View {
        let websiteUrl = URL(string: "https://www.athlety.app")!
        Link("www.athlety.app", destination: websiteUrl)
            .padding(.top)
    }
    
    @ViewBuilder
    private var versionText: some View {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        Text("v\(version)")
            .font(.subheadline)
            .foregroundStyle(.secondary)
    }
    
    private var aboutText: some View {
        Text("Athlety is an app for track and field athletes, coaches, and anyone interested in athletics in Germany.\n\n" +
             "The app provides an overview of upcoming competitions and events and allows you to save important dates for quick access. " +
             "It is designed to help you stay organized throughout the athletics season.\n\n" +
             "Athlety is developed and published by Stefan Lipp in Regensburg, Germany. " +
             "Your feedback and suggestions are always welcome and help improve the app."
        )
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
