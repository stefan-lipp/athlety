//
//  EventDisciplineTagsView.swift
//  Athlety
//
//  Created by Stefan Lipp on 23.01.26.
//

import SwiftUI

struct EventDisciplineTagsView: View {
    
    let disciplines: [Discipline]
    
    var body: some View {
        VStack(alignment: .leading) {
            ListSectionHeader(title: "Disciplines")
            
            WrappingHStack(alignment: .leading) {
                ForEach(disciplines) { discipline in
                    tag(for: discipline)
                }
            }
            .padding(.top)
        }
    }
    
    private func tag(for discipline: Discipline) -> some View {
        Text(discipline.localized)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background { tagBackground }
    }
    
    private var tagBackground: some View {
        Capsule().fill(Color(UIColor.tertiarySystemFill))
    }
}

#Preview {
    let disciplines: [Discipline] = [
        .sprint100m, .sprint200m, .sprint400m,
        .running800m, .running3000m, .running5000m,
        .highJump, .longJump, .shotPut, .javelinThrow
    ]
    EventDisciplineTagsView(disciplines: disciplines)
        .padding()
}
