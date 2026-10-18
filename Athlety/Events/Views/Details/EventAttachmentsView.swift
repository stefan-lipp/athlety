//
//  EventAttachmentsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 21.08.25.
//

import SwiftUI

struct EventAttachmentsView: View {
    let attachments: [EventAttachment]

    var body: some View {
        ForEach(attachments, id: \.name) { attachment in
            NavigationLink {
                EventWebView(name: attachment.name, url: attachment.url)
            } label: {
                Label(attachment.name, systemImage: "doc")
            }
            .padding(.vertical, 8)
        }
    }
}
