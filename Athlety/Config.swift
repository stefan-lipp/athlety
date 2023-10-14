//
//  Config.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import Foundation

class Config {
    
    let ladvApiKey: String
    let ladvBaseUrl: String
    let ladvProfileId: Int
    
    private init(ladvApiKey: String, ladvBaseUrl: String, ladvProfileId: Int) {
        self.ladvApiKey = ladvApiKey
        self.ladvBaseUrl = ladvBaseUrl
        self.ladvProfileId = ladvProfileId
    }
    
    static var shared: Config = {
        guard let configPath = Bundle.main.path(forResource: "Config", ofType: "plist") else {
            fatalError("A Config.plist file is required within the Athlety directory." +
                       "Please refer to the README for more information on how to correctly set up the Config.plist file.")
        }
        
        do {
            let configData = try Data(contentsOf: URL(fileURLWithPath: configPath))
            
            guard let config = try PropertyListSerialization.propertyList(from: configData, format: nil) as? [String: Any],
                  let ladvConfig = config["LADV"] as? [String: Any],
                  let ladvApiKey = ladvConfig["APIKey"] as? String, !ladvApiKey.isEmpty,
                  let ladvBaseUrl = ladvConfig["BaseURL"] as? String, !ladvBaseUrl.isEmpty,
                  let ladvProfileIdString = ladvConfig["ProfileID"] as? String, !ladvProfileIdString.isEmpty,
                  let ladvProfileId = Int(ladvProfileIdString)
            else {
                fatalError("Could not find required keys and values in Config.plist file. " +
                           "Please refer to the README for more information on how to correctly set up the Config.plist file.")
            }
            
            return Config(ladvApiKey: ladvApiKey, ladvBaseUrl: ladvBaseUrl, ladvProfileId: ladvProfileId)
            
        } catch {
            fatalError("Invalid Config.plist file found in Athlety directory." +
                       "Please refer to the README for more information on how to correctly set up the Config.plist file.")
        }
    }()
}
