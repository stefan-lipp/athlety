//
//  EventsFilterToolbar.swift
//  Athlety
//
//  Created by Stefan Cimander on 25.05.23.
//

import SwiftUI

struct EventsFilterToolbar: ToolbarContent {
    
    let onCancel: () -> Void
    let onDone: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                onCancel()
            } label: {
                Text("Cancel")
            }
        }
        ToolbarItem(placement: .confirmationAction) {
            Button {
                onDone()
            } label: {
                Text("Done")
            }
        }
    }
}
