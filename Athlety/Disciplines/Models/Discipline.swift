//
//  Discipline.swift
//  Athlety
//
//  Created by Stefan Lipp on 22.01.26.
//

import SwiftUI

enum Discipline: String, CaseIterable, Identifiable, Hashable {
    case sprint60m = "60m"
    case sprint100m = "100m"
    case sprint200m = "200m"
    case sprint400m = "400m"
    
    case running600m = "600m"
    case running800m = "800m"
    case running1500m = "1500m"
    case running2000m = "2000m"
    case running3000m = "3000m"
    case running5000m = "5000m"
    
    case hurdles60m = "60m Hurdles"
    
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
        case .sprint60m: "\(60)m"
        case .sprint100m: "\(100)m"
        case .sprint200m: "\(200)m"
        case .sprint400m: "\(400)m"
            
        case .running600m: "\(600)m"
        case .running800m: "\(800)m"
        case .running1500m: "\(1500)m"
        case .running2000m: "\(2000)m"
        case .running3000m: "\(3000)m"
        case .running5000m: "\(5000)m"
            
        case .hurdles60m: "\(60)m Hurdles"
        
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
