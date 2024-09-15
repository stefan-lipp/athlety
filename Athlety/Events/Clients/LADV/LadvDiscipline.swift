//
//  LadvDisciplilne.swift
//  Athlety
//
//  Created by Stefan Lipp on 15.09.24.
//

import Foundation

extension Discipline {
    
    static var disciplineForLadvCode: [String : Discipline] {
        [
            "L100" : .sprint100m,
            "L800" : .run800m,
            "TWEI" : .longJump,
            "THOC" : .highJump,
            "TSPE" : .javelinThrow,
            "TKUG" : .shotPut
        ]
    }
}
