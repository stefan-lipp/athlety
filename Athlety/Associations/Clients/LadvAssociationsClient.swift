//
//  LadvAssociationsClient.swift
//  Athlety
//
//  Created by Stefan Lipp on 29.06.25.
//

import Foundation

nonisolated struct LadvAssociationsClient: AssociationsClient, Sendable {
    private let associationsUrl: URL

    init(
        baseUrl: String = AppConfig.shared.ladvBaseUrl,
        apiKey: String = AppConfig.shared.ladvApiKey
    ) {
        associationsUrl = URL(string: "\(baseUrl)/\(apiKey)/lvList")!
    }

    @concurrent
    func loadAssociations() async -> [Association] {
        let request = URLRequest(url: associationsUrl)

        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return [] }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }
        guard let ladvAssociations = try? JSONDecoder().decode([LadvAssociation].self, from: data) else { return [] }

        return ladvAssociations
            .map { $0.toAssociation() }
            .filter { $0.id != "RH" }
            .filter { $0.id != "RS" }
            .filter { $0.id != "INT" }
            .sorted { $0.name < $1.name }
    }
}

private nonisolated struct LadvAssociation: Codable, Sendable {
    let id: String
    let name: String

    func toAssociation() -> Association {
        Association(id: id, name: name)
    }
}
