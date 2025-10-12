//
//  EventAttachementsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 21.08.25.
//

import SwiftUI
import WebKit

struct EventAttachementsView: View {
    let attachements: [Attachement]
    
    var body: some View {
        ForEach(attachements, id: \.name) { attachement in
            NavigationLink {
                WebView(url: attachement.url)
                    .navigationTitle(attachement.name)
            } label: {
                Label(attachement.name, systemImage: "doc")
            }
            .padding(.vertical, 8)
        }
    }
}
