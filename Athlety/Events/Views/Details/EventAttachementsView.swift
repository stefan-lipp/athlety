//
//  EventAttachementsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 20.10.23.
//

import SwiftUI

struct EventAttachementsView: View {
    
    let attachements: [Attachement]
    
    var body: some View {
        ForEach(attachements, id: \.name) { attachement in
            NavigationLink {
                AttachementView(url: attachement.url)
                    .navigationTitle(attachement.name)
            } label: {
                Label(attachement.name, systemImage: "doc")
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    EventAttachementsView(attachements: [])
}
