//
//  Appearance.swift
//  Athlety
//
//  Created by Stefan Lipp on 06.01.26.
//

import SwiftUI

enum Appearance: String, CaseIterable, Identifiable {
    case system = "System"
    case light = "Light"
    case dark = "Dark"
    
    var localized: LocalizedStringKey {
        switch self {
        case .system: "System"
        case .light: "Light"
        case .dark: "Dark"
        }
    }
    
    var id: String { rawValue }
}
