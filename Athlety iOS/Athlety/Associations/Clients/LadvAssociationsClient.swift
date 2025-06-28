//
//  LadvAssociationsClient.swift
//  Athlety
//
//  Created by Stefan Lipp on 29.06.25.
//

import Foundation

class LadvAssociationsClient: AssociationsClient {
    
    private static let baseUrl = AppConfig.shared.ladvBaseUrl
    private static let apiKey = AppConfig.shared.ladvApiKey
    
    private let associationsUrl = URL(string: "\(baseUrl)/\(apiKey)/lvList")!
    
    func loadAssociations() async -> [Association] {
        let request = URLRequest(url: associationsUrl)
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return [] }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }
        guard let ladvAssociations = try? JSONDecoder().decode([LadvAssociation].self, from: data) else { return [] }
        
        return ladvAssociations
            .map { $0.toAssociation() }
            .filter { $0.id != "RS" }
            .filter { $0.id != "INT" }
            .sorted { $0.name < $1.name }
    }
}

private struct LadvAssociation: Codable {
    let id: String
    let name: String
    
    func toAssociation() -> Association {
        return Association(id: id, name: name)
    }
}
