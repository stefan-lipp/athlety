//
//  EventLocation.swift
//  Athlety
//
//  Created by Stefan Lipp on 11.07.25.
//

import Foundation

struct EventLocation: CustomStringConvertible {
    let name: String
    let site: String
    let latitude: Double
    let longitude: Double
    
    var description: String {
        "\(site), \(name)"
    }
}
