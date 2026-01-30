//
//  SettingsStore.swift
//  Athlety
//
//  Created by Stefan Lipp on 06.01.26.
//

import Combine
import SwiftUI

class SettingsStore: ObservableObject {
    
    @AppStorage("showOnboarding") var showAppOnboarding = true
    
    @AppStorage("appAppearance") var appAppearance: Appearance = .system
    
    var colorScheme: ColorScheme? {
        switch appAppearance {
        case .light:
            return .light
        case .dark:
            return .dark
        case .system:
            return nil
        }
    }
}
