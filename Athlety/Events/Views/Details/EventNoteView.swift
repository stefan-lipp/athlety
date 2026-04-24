//
//  EventNoteView.swift
//  Athlety
//
//  Created by Stefan Lipp on 01.01.26.
//

import SwiftUI

struct EventNoteView: View {
    let isCancelled: Bool
    let note: String?

    var body: some View {
        VStack(alignment: .leading) {
            ListSectionHeader(title: "Note")

            if isCancelled {
                cancellationNote
            } else if let note {
                noteText(note)
            }
        }
    }

    private var cancellationNote: some View {
        Label("The event was cancelled.", systemImage: "xmark.circle")
            .padding(.top, 12)
            .padding(.bottom)
    }

    private func noteText(_ note: String) -> some View {
        Text(note)
            .padding(.top, 4)
            .padding(.bottom)
    }
}
