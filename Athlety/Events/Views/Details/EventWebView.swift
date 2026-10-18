//
//  EventWebView.swift
//  Athlety
//
//  Created by Stefan Lipp on 16.10.26.
//

import SwiftUI
import WebKit

struct EventWebView: View {
    let name: String
    let url: URL

    var body: some View {
        WebView(url: url)
            .navigationTitle(name)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    ShareLink(item: url, subject: Text(name))
                }
            }
    }
}

#Preview {
    NavigationStack {
        EventWebView(name: "Ausschreibung", url: URL(string: "https://ladv.de/ausschreibung/datei/494050?file=true")!)
    }
}
