//
//  EventAttachmentsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 21.08.25.
//

import SwiftUI
import WebKit

struct EventAttachmentsView: View {
    let attachments: [EventAttachment]
    
    var body: some View {
        ForEach(attachments, id: \.name) { attachment in
            NavigationLink {
                WebView(url: attachment.url)
                    .navigationTitle(attachment.name)
            } label: {
                Label(attachment.name, systemImage: "doc")
            }
            .padding(.vertical, 8)
        }
    }
}
