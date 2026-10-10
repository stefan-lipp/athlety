//
//  EventResultsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 10.10.26.
//

import SwiftUI
import WebKit

struct EventResultsView: View {
    let results: [EventResult]

    var body: some View {
        ForEach(results, id: \.url) { result in
            NavigationLink {
                WebView(url: result.url)
                    .navigationTitle(result.name)
            } label: {
                Label(result.name, systemImage: "list.number")
            }
            .padding(.vertical, 8)
        }
    }
}
