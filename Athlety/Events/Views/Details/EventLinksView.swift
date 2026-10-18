//
//  EventLinksView.swift
//  Athlety
//
//  Created by Stefan Lipp on 10.12.25.
//

import SwiftUI

struct EventLinksView: View {
    let url: URL?
    let links: [EventLink]

    var body: some View {
        if let url {
            NavigationLink {
                EventWebView(name: "LADV", url: url)
            } label: {
                Label("Open on LADV", systemImage: "network")
            }
            .padding(.vertical, 8)
        }

        ForEach(links, id: \.name) { link in
            NavigationLink {
                EventWebView(name: link.name, url: link.url)
            } label: {
                Label(link.name, systemImage: "network")
            }
            .padding(.vertical, 8)
        }
    }
}
