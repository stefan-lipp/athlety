//
//  Item.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
