//
//  EventNoteView.swift
//  Athlety
//
//  Created by Stefan Lipp on 01.01.26.
//

import SwiftUI

struct EventNoteView: View {
    let note: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ListSectionHeader(title: "Note")
            
            Text(note)
                .padding(.vertical)
        }
    }
}
