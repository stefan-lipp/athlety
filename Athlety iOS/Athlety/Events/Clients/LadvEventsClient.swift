//
//  LadvEventsClient.swift
//  Athlety
//
//  Created by Stefan Lipp on 28.06.25.
//

import Foundation

class LadvEventsClient: EventsClient {
    
    private static let baseUrl = AppConfig.shared.ladvBaseUrl
    private static let apiKey = AppConfig.shared.ladvApiKey
    
    private let eventsUrl = "\(baseUrl)/\(apiKey)/ausList"
    
    func loadUpcomingEvents() async -> [Event] {
        var urlComponents = URLComponents(string: eventsUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "mostCurrent", value: "true"),
            URLQueryItem(name: "limit", value: "200")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return [] }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }
        
        let ladvEvents = try! JSONDecoder().decode([LadvEvent].self, from: data)
        return ladvEvents.map { $0.toEvent() }
    }
}

private struct LadvEvent: Codable {
    let id: Int
    let name: String
    let ort: String
    let datum: Int
    
    func toEvent() -> Event {
        let dateMillis = datum
        let dateSeconds = Double(dateMillis) / 1000
        let date = Date(timeIntervalSince1970: dateSeconds)
        return Event(id: id, name: name, location: ort, date: date)
    }
}
