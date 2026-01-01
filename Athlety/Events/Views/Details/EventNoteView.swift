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
            Text("Note")
                .fontWeight(.medium)
                .font(.title2)
                .padding(.bottom)
            
            Text(note)
                .padding(.bottom)
        }
    }
}
