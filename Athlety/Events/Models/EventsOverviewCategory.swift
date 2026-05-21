//
//  EventsOverviewCategory.swift
//  Athlety
//
//  Created by Stefan Lipp on 21.05.26.
//

import SwiftUI

enum EventsOverviewCategory {
    case upcoming
    case saved

    var icon: String {
        self == .upcoming ? "square.stack" : "bookmark"
    }

    var title: LocalizedStringKey {
        self == .upcoming ? "Upcoming" : "Saved"
    }
}
