//
//  AppConfig.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Foundation

class AppConfig {
    
    let ladvBaseUrl: String
    let ladvApiKey: String
    
    private init(ladvBaseUrl: String, ladvApiKey: String) {
        self.ladvBaseUrl = ladvBaseUrl
        self.ladvApiKey = ladvApiKey
    }
    
    static var shared: AppConfig = {
        guard let appConfigPath = Bundle.main.path(forResource: "AppConfig", ofType: "plist") else {
            fatalError("An AppConfig.plist file is required within the Athlety directory. " + explanation)
        }
        
        do {
            let appConfigData = try Data(contentsOf: URL(fileURLWithPath: appConfigPath))
            guard let appConfig = try PropertyListSerialization.propertyList(from: appConfigData, format: nil) as? [String: Any],
                  let ladvConfig = appConfig["LADV"] as? [String: Any],
                  let ladvBaseUrl = ladvConfig["BaseURL"] as? String, !ladvBaseUrl.isEmpty,
                  let ladvApiKey = ladvConfig["APIKey"] as? String, !ladvApiKey.isEmpty
            else {
                fatalError("Could not find required keys and values in AppConfig.plist file. " + explanation)
            }
            return AppConfig(ladvBaseUrl: ladvBaseUrl, ladvApiKey: ladvApiKey)
            
        } catch {
            fatalError("Invalid AppConfig.plist file found in Athlety directory. " + explanation)
        }
    }()
    
    private static let explanation = "Please refer to the README.md file for more information on how to correctly set up the AppConfig.plist file."
}
