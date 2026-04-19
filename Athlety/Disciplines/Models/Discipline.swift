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
    case running1000m
    case running1500m
    case running2000m
    case running3000m
    case running5000m
    case running10000m
    
    case roadRunning
    case crossCountry

    case hurdles60m
    case hurdles80m
    case hurdles100m
    case hurdles110m
    case hurdles400m

    case steeplechase1500m
    case steeplechase2000m
    case steeplechase3000m

    case relay4x50m
    case relay4x75m
    case relay4x100m
    case relay4x400m
    case relay3x800m
    case relay3x1000m
    
    case highJump
    case longJump
    case tripleJump
    case poleVault
    
    case ballThrow
    case shotPut
    case discusThrow
    case javelinThrow
    case hammerThrow
    
    case triathlon
    case quadrathlon
    case pentathlon
    case hexathlon
    case heptathlon
    case octathlon
    case nonathlon
    case decathlon

    case blockSprint
    case blockRun
    case blockThrow
    case blockTeam

    case childrensAthletics

    enum Category: String, CaseIterable, Identifiable {
        case sprint, running, hurdles, steeplechase, relays, jumps, throwing, multiEvents, blockEvents

        var id: String { rawValue }

        var displayName: String {
            switch self {
            case .sprint: String(localized: "Sprint")
            case .running: String(localized: "Running")
            case .hurdles: String(localized: "Hurdles")
            case .steeplechase: String(localized: "Steeplechase")
            case .relays: String(localized: "Relays")
            case .jumps: String(localized: "Jumps")
            case .throwing: String(localized: "Throws")
            case .multiEvents: String(localized: "Multi-Events")
            case .blockEvents: String(localized: "Block Events")
            }
        }
    }

    var id: String {
        return rawValue
    }

    var category: Category? {
        switch self {
        case .sprint30m, .sprint40m, .sprint50m, .sprint60m, .sprint75m, .sprint80m,
             .sprint100m, .sprint150m, .sprint200m, .sprint300m, .sprint400m:
            .sprint
        case .running500m, .running600m, .running800m, .running1000m, .running1500m,
             .running2000m, .running3000m, .running5000m, .running10000m, .crossCountry, .roadRunning:
            .running
        case .hurdles60m, .hurdles80m, .hurdles100m, .hurdles110m, .hurdles400m:
            .hurdles
        case .steeplechase1500m, .steeplechase2000m, .steeplechase3000m:
            .steeplechase
        case .relay4x50m, .relay4x75m, .relay4x100m, .relay4x400m, .relay3x800m, .relay3x1000m:
            .relays
        case .highJump, .longJump, .tripleJump, .poleVault:
            .jumps
        case .ballThrow, .shotPut, .discusThrow, .javelinThrow, .hammerThrow:
            .throwing
        case .triathlon, .quadrathlon, .pentathlon, .hexathlon, .heptathlon,
             .octathlon, .nonathlon, .decathlon:
            .multiEvents
        case .blockSprint, .blockRun, .blockThrow, .blockTeam:
            .blockEvents
        default:
            nil
        }
    }

    static func disciplines(for category: Category) -> [Discipline] {
        allCases.filter { $0.category == category }
    }
    
    var displayName: String {
        switch self {
        case .sprint30m: String(localized: "\(30) m")
        case .sprint40m: String(localized: "\(40) m")
        case .sprint50m: String(localized: "\(50) m")
        case .sprint60m: String(localized: "\(60) m")
        case .sprint75m: String(localized: "\(75) m")
        case .sprint80m: String(localized: "\(80) m")
        case .sprint100m: String(localized: "\(100) m")
        case .sprint150m: String(localized: "\(150) m")
        case .sprint200m: String(localized: "\(200) m")
        case .sprint300m: String(localized: "\(300) m")
        case .sprint400m: String(localized: "\(400) m")

        case .running500m: String(localized: "\(500) m")
        case .running600m: String(localized: "\(600) m")
        case .running800m: String(localized: "\(800) m")
        case .running1000m: String(localized: "\(1000) m")
        case .running1500m: String(localized: "\(1500) m")
        case .running2000m: String(localized: "\(2000) m")
        case .running3000m: String(localized: "\(3000) m")
        case .running5000m: String(localized: "\(5000) m")
        case .running10000m: String(localized: "\(10000) m")

        case .roadRunning: String(localized: "Road Running")
        case .crossCountry: String(localized: "Cross Country")

        case .hurdles60m: String(localized: "\(60) m Hurdles")
        case .hurdles80m: String(localized: "\(80) m Hurdles")
        case .hurdles100m: String(localized: "\(100) m Hurdles")
        case .hurdles110m: String(localized: "\(110) m Hurdles")
        case .hurdles400m: String(localized: "\(400) m Hurdles")

        case .steeplechase1500m: String(localized: "\(1500) m Steeplechase")
        case .steeplechase2000m: String(localized: "\(2000) m Steeplechase")
        case .steeplechase3000m: String(localized: "\(3000) m Steeplechase")

        case .relay4x50m: String(localized: "\(4)×\(50) m Relay")
        case .relay4x75m: String(localized: "\(4)×\(75) m Relay")
        case .relay4x100m: String(localized: "\(4)×\(100) m Relay")
        case .relay4x400m: String(localized: "\(4)×\(400) m Relay")
        case .relay3x800m: String(localized: "\(3)×\(800) m Relay")
        case .relay3x1000m: String(localized: "\(3)×\(1000) m Relay")

        case .highJump: String(localized: "High Jump")
        case .longJump: String(localized: "Long Jump")
        case .tripleJump: String(localized: "Triple Jump")
        case .poleVault: String(localized: "Pole Vault")

        case .ballThrow: String(localized: "Ball Throw")
        case .shotPut: String(localized: "Shot Put")
        case .discusThrow: String(localized: "Discus Throw")
        case .javelinThrow: String(localized: "Javelin Throw")
        case .hammerThrow: String(localized: "Hammer Throw")

        case .triathlon: String(localized: "Triathlon")
        case .quadrathlon: String(localized: "Quadrathlon")
        case .pentathlon: String(localized: "Pentathlon")
        case .hexathlon: String(localized: "Hexathlon")
        case .heptathlon: String(localized: "Heptathlon")
        case .octathlon: String(localized: "Octathlon")
        case .nonathlon: String(localized: "Nonathlon")
        case .decathlon: String(localized: "Decathlon")

        case .blockSprint: String(localized: "Block Sprint/Jump")
        case .blockRun: String(localized: "Block Running")
        case .blockThrow: String(localized: "Block Throwing")
        case .blockTeam: String(localized: "Block Team")

        case .childrensAthletics: String(localized: "Children's Athletics")
        }
    }
}
