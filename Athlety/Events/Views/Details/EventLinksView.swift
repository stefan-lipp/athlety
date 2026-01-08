//
//  EventLinksView.swift
//  Athlety
//
//  Created by Stefan Lipp on 10.12.25.
//

import SwiftUI
import WebKit

struct EventLinksView: View {
    let links: [EventLink]
    
    var body: some View {
        ForEach(links, id: \.name) { link in
            NavigationLink {
                WebView(url: link.url)
                    .navigationTitle(link.name)
            } label: {
                Label(link.name, systemImage: "network")
            }
            .padding(.vertical, 8)
        }
    }
}
