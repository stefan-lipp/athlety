//
//  LadvProfileClient.swift
//  Athlety
//
//  Created by Stefan Lipp on 14.10.23.
//

import Foundation

class LadvProfileClient : ProfileClient {
    
    private static let baseUrl = Config.shared.ladvBaseUrl
    private static let apiKey = Config.shared.ladvApiKey
    private static let profileId = Config.shared.ladvProfileId
    
    private let eventsUrl = "\(baseUrl)/\(apiKey)/athletDetail"
    
    func loadProfile(with profileId: Int) async -> Profile? {
        var urlComponents = URLComponents(string: eventsUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: "\(profileId)")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return nil }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return nil }
        
        let ladvAthletes = try! JSONDecoder().decode([LadvAthlete].self, from: data)
        guard let ladvAthlete = ladvAthletes.first else { return nil }
        return toProfile(ladvAthlete)
    }
    
    private func toProfile(_ ladvAthlete: LadvAthlete) -> Profile {
        return Profile(
            id: ladvAthlete.id,
            firstName: ladvAthlete.forename,
            lastName: ladvAthlete.surname,
            birthyear: ladvAthlete.birthyear
        )
    }
    
    private struct LadvAthlete: Codable {
        let id: Int
        let forename: String
        let surname: String
        let birthyear: Int
    }
}
