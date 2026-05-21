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

        LabeledContent {
            Text(registration.host)
        } label: {
            Label("Host", systemImage: "mappin.and.ellipse")
        }
        .padding(.vertical, 8)

        if let url = URL(string: "mailto:\(registration.email)") {
            Link(destination: url) {
                LabeledContent {
                    Text(registration.email)
                } label: {
                    Label("Email", systemImage: "paperplane")
                }
            }
            .padding(.vertical, 8)
        }

        LabeledContent {
            Text(registration.deadline, format: .dateTime.weekday(.wide).day().month(.wide).year())
        } label: {
            Label("Deadline", systemImage: "calendar.badge.exclamationmark")
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    let registration = EventRegistration(host: "LG Stadtwerke München", email: "registration@event.de", deadline: Date())
    return EventRegistrationView(registration: registration)
}
