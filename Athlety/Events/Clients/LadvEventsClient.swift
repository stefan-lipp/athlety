//
//  LadvEventsClient.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import Foundation

class LadvEventsClient: EventsClient {
    
    private static let baseUrl = Config.shared.ladvBaseUrl
    private static let apiKey = Config.shared.ladvApiKey
    private static let maxNumberOfEvents = 200
    private let eventsUrl = URL(string: "\(baseUrl)/\(apiKey)/ausList?&mostCurrent=true&limit=\(maxNumberOfEvents)")!
    
    func loadUpcomingEvents() async -> [Event] {
        let request = URLRequest(url: eventsUrl)
        let (data, response) = try! await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }
        let ladvEvents = try! JSONDecoder().decode([LadvEvent].self, from: data)
        return ladvEvents.map(toEvent)
    }
    
    private func toEvent(_ ladvEvent: LadvEvent) -> Event {
        let dateMillis = ladvEvent.datum
        let dateSeconds = Double(dateMillis) / 1000
        return Event(id: ladvEvent.id, name: ladvEvent.name, location: ladvEvent.ort, date: Date(timeIntervalSince1970: dateSeconds))
    }
    
    private struct LadvEvent: Codable {
        let id: Int
        let name: String
        let ort: String
        let datum: Int
    }
}
