//
//  Discipline.swift
//  Athlety
//
//  Created by Stefan Lipp on 22.01.26.
//

import SwiftUI

enum Discipline: String, CaseIterable, Identifiable, Hashable {
    case sprint30m
    case sprint40m
    case sprint50m
    case sprint60m
    case sprint75m
    case sprint80m
    case sprint100m
    case sprint150m
    case sprint200m
    case sprint300m
    case sprint400m
    
    case running500m
    case running600m
    case running800m
    case running1500m
    case running2000m
    case running3000m
    case running5000m
    case running10000m
    
    case hurdles60m
    case hurdles100m
    case hurdles110m
    case hurdles400m
    
    case highJump
    case longJump
    case poleVault
    
    case shotPut
    case javelinThrow
    case hammerThrow
    
    case quadrathlon
    case pentathlon
    
    case childrensAthletics
    
    case crossCountry
    
    var id: String {
        return rawValue
    }
    
    var localized: LocalizedStringKey {
        switch self {
        case .sprint30m: "\(30) m"
        case .sprint40m: "\(40) m"
        case .sprint50m: "\(50) m"
        case .sprint60m: "\(60) m"
        case .sprint75m: "\(75) m"
        case .sprint80m: "\(80) m"
        case .sprint100m: "\(100) m"
        case .sprint150m: "\(150) m"
        case .sprint200m: "\(200) m"
        case .sprint300m: "\(300) m"
        case .sprint400m: "\(400) m"

        case .running500m: "\(500) m"
        case .running600m: "\(600) m"
        case .running800m: "\(800) m"
        case .running1500m: "\(1500) m"
        case .running2000m: "\(2000) m"
        case .running3000m: "\(3000) m"
        case .running5000m: "\(5000) m"
        case .running10000m: "\(10000) m"

        case .hurdles60m: "\(60) m Hurdles"
        case .hurdles100m: "\(100) m Hurdles"
        case .hurdles110m: "\(110) m Hurdles"
        case .hurdles400m: "\(400) m Hurdles"

        case .longJump: "Long Jump"
        case .highJump: "High Jump"
        case .poleVault: "Pole Vault"

        case .shotPut: "Shot Put"
        case .javelinThrow: "Javelin Throw"
        case .hammerThrow: "Hammer Throw"

        case .quadrathlon: "Quadrathlon"
        case .pentathlon: "Pentathlon"

        case .childrensAthletics: "Children's Athletics"

        case .crossCountry: "Cross Country"
        }
    }
}
