//
//  EventResultsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 10.10.26.
//

import SwiftUI

struct EventResultsView: View {
    let results: [EventResult]

    var body: some View {
        ForEach(results, id: \.url) { result in
            NavigationLink {
                EventWebView(name: result.name, url: result.url)
            } label: {
                Label(result.name, systemImage: "list.number")
            }
            .padding(.vertical, 8)
        }
    }
}
