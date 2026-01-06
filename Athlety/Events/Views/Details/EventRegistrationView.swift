//
//  EventRegistrationView.swift
//  Athlety
//
//  Created by Stefan Lipp on 02.12.25.
//

import SwiftUI

struct EventRegistrationView: View {
    
    let registration: EventRegistration
    
    var body: some View {
        ListSectionHeader(title: "Registration")
        
        if let url = URL(string: "mailto:\(registration.email)") {
            Link(destination: url) {
                HStack(alignment: .center) {
                    Label("Email", systemImage: "paperplane")
                    Spacer()
                    Text(registration.email)
                }
            }
            .padding(.bottom, 8)
        }
        
        HStack {
            Label("Deadline", systemImage: "calendar.badge.exclamationmark")
            Spacer()
            Text(formattedDeadline)
        }
        .padding(.vertical, 8)
    }
    
    private var formattedDeadline: String {
        registration.deadline.formatted(.dateTime.weekday(.wide).day().month(.wide).year())
    }
}

#Preview {
    let registration = EventRegistration(deadline: Date(), email: "registration@event.de")
    return EventRegistrationView(registration: registration)
}
