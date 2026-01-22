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
    
    case running800m = "800m"
    case running3000m = "3000m"
    case running5000m = "5000m"
    
    case highJump
    case longJump
    
    case shotPut
    case javelinThrow
    
    var id: String {
        return rawValue
    }
    
    var localized: LocalizedStringKey {
        switch self {
        case .sprint60m: "\(60)m"
        case .sprint100m: "\(100)m"
        case .sprint200m: "\(200)m"
        case .sprint400m: "\(400)m"
            
        case .running800m: "\(800)m"
        case .running3000m: "\(3000)m"
        case .running5000m: "\(5000)m"
        
        case .longJump: "Long Jump"
        case .highJump: "High Jump"
            
        case .shotPut: "Shot Put"
        case .javelinThrow: "Javelin Throw"
        }
    }
}
