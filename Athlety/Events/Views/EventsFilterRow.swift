//
//  EventsFilterRow.swift
//  Athlety
//
//  Created by Stefan Cimander on 24.05.23.
//

import SwiftUI

struct EventsFilterRow: View {
    
    let name: LocalizedStringKey
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button {
            onSelect()
        } label: {
            HStack {
                Text(name)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.accentColor)
                        .fontWeight(.bold)
                }
            }
        }
    }
}
