//
//  EventDisciplinesView.swift
//  Athlety
//
//  Created by Stefan Lipp on 15.09.24.
//

import SwiftUI

struct EventDisciplinesView: View {
    
    let disciplines: [Discipline]
    
    var body: some View {
        Text("Disciplines")
            .fontWeight(.medium)
            .font(.title2)
            .padding(.top)
            .padding(.bottom, 8)
        
        ForEach(disciplines, id: \.self) { discipline in
            Text(discipline.rawValue)
                .padding(.vertical, 8)
        }
    }
}
