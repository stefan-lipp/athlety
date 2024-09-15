//
//  LadvEvent.swift
//  Athlety
//
//  Created by Stefan Lipp on 15.09.24.
//

import Foundation

struct LadvEvent: Codable {
    let id: Int
    let name: String
    let ort: String
    let datum: Int
}

struct LadvEventDetails: Codable {
    let id: Int
    let name: String
    let ort: LadvEventLocation
    let sportstaette: String
    let datum: Int
    
    let meldEmail: String
    let meldDatum: Int
    
    let attachements: [LadvEventAttachement]
    let wettbewerbe: [LadvEventCompetition]
}

struct LadvEventLocation: Codable {
    let id: Int
    let name: String
    let lat: Double
    let lng: Double
}

struct LadvEventAttachement: Codable {
    let name: String
    let url: String
    let fileExtension: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case fileExtension = "extension"
    }
}

struct LadvEventCompetition: Codable {
    let disziplinNew: String
    let klasseNew: String
}
