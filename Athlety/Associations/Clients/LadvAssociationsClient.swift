//
//  LadvAssociationsClient.swift
//  Athlety
//
//  Created by Stefan Cimander on 24.05.23.
//

import Foundation

@MainActor
class LadvAssociationsClient: AssociationsClient {
    
    private static let baseUrl = Config.shared.ladvBaseUrl
    private static let apiKey = Config.shared.ladvApiKey
    
    private let associationsUrl = URL(string: "\(baseUrl)/\(apiKey)/lvList")!
    
    func loadAssociations() async -> [Association] {
        let request = URLRequest(url: associationsUrl)
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return [] }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }
        guard let ladvAssociations = try? JSONDecoder().decode([LadvAssociation].self, from: data) else { return [] }
        
        return ladvAssociations
            .map { toAssociation($0) }
            .filter { $0.id != "RS" }
            .filter { $0.id != "INT" }
            .sorted { $0.name < $1.name }
    }
    
    private func toAssociation(_ ladvAssociation: LadvAssociation) -> Association {
        return Association(id: ladvAssociation.id, name: ladvAssociation.name)
    }
    
    private struct LadvAssociation: Codable {
        let id: String
        let name: String
    }
}
