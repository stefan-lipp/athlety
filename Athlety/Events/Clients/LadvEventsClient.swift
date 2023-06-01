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
    
    private let eventsUrl = "\(baseUrl)/\(apiKey)/ausList"
    private let eventDetailsUrl = "\(baseUrl)/\(apiKey)/ausDetail"
    
    func loadUpcomingEvents(for associationId: String?) async -> [Event] {
        var urlComponents = URLComponents(string: eventsUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "mostCurrent", value: "true"),
            URLQueryItem(name: "limit", value: "200")
        ]
        if associationId != nil {
            urlComponents.queryItems?.append(URLQueryItem(name: "lv", value: associationId))
        }
        
        let request = URLRequest(url: urlComponents.url!)
        let (data, response) = try! await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }
        let ladvEvents = try! JSONDecoder().decode([LadvEvent].self, from: data)
        return ladvEvents.map(toEvent)
    }
    
    func loadEventDetails(for eventId: Int) async -> EventDetails? {
        var urlComponents = URLComponents(string: eventDetailsUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: "\(eventId)"),
            URLQueryItem(name: "ort", value: "true"),
            URLQueryItem(name: "wettbewerbe", value: "true")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        let (data, response) = try! await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return nil }
        let ladvEvents = try! JSONDecoder().decode([LadvEventDetails].self, from: data)
        guard let ladvEvent = ladvEvents.first else { return nil }
        return toEventDetails(ladvEvent)
    }
    
    
    private func toEvent(_ ladvEvent: LadvEvent) -> Event {
        let dateMillis = ladvEvent.datum
        let dateSeconds = Double(dateMillis) / 1000
        let date = Date(timeIntervalSince1970: dateSeconds)
        return Event(id: ladvEvent.id, name: ladvEvent.name, location: ladvEvent.ort, date: date)
    }
    
    private func toEventDetails(_ ladvEvent: LadvEventDetails) -> EventDetails {
        let dateMillis = ladvEvent.datum
        let dateSeconds = Double(dateMillis) / 1000
        let date = Date(timeIntervalSince1970: dateSeconds)
        return EventDetails(id: ladvEvent.id, name: ladvEvent.name, location: ladvEvent.ort.name, address: ladvEvent.sportstaette, date: date, disciplines: [])
    }
    
    
    private struct LadvEvent: Codable {
        let id: Int
        let name: String
        let ort: String
        let datum: Int
    }
    
    private struct LadvEventDetails: Codable {
        let id: Int
        let name: String
        let ort: LadvEventLocation
        let sportstaette: String
        let datum: Int
    }
    
    private struct LadvEventLocation: Codable {
        let id: Int
        let name: String
    }
}
