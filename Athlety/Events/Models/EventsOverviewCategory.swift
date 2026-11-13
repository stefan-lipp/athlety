//
//  EventsOverviewCategory.swift
//  Athlety
//
//  Created by Stefan Lipp on 21.05.26.
//

import SwiftUI

enum EventsOverviewCategory {
    case upcoming
    case past
    case saved

    var icon: String {
        switch self {
        case .upcoming: "square.stack"
        case .past: "trophy"
        case .saved: "bookmark"
        }
    }

    var title: LocalizedStringKey {
        switch self {
        case .upcoming: "Upcoming"
        case .past: "Past"
        case .saved: "Saved"
        }
    }
}
