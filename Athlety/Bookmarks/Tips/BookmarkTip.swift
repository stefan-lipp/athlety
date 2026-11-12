//
//  BookmarkTip.swift
//  Athlety
//
//  Created by Stefan Lipp on 12.11.26.
//

import SwiftUI
import TipKit

struct BookmarkTip: Tip {
    static let eventDetailsViewed = Tips.Event(id: "eventDetailsViewed")

    @Parameter static var hasBookmarks: Bool = false

    var title: Text {
        Text("Save this event")
    }

    var message: Text? {
        Text("Bookmark events to find them quickly in your saved events.")
    }

    var image: Image? {
        Image(systemName: "bookmark")
    }

    var rules: [Rule] {
        #Rule(Self.$hasBookmarks) { $0 == false }
        #Rule(Self.eventDetailsViewed) { $0.donations.count >= 5 }
    }
}
