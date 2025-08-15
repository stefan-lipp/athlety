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
    private let eventDetailsUrl = "\(baseUrl)/\(apiKey)/ausDetail"
    
    func loadUpcomingEvents(for associationId: String?) async -> [Event] {
        var urlComponents = URLComponents(string: eventsUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "mostCurrent", value: "true"),
            URLQueryItem(name: "limit", value: "200")
        ]
        if let associationId {
            urlComponents.queryItems?.append(URLQueryItem(name: "lv", value: associationId))
        }
        let request = URLRequest(url: urlComponents.url!)
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return [] }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }
        
        let ladvEvents = try! JSONDecoder().decode([LadvEvent].self, from: data)
        return ladvEvents.map { $0.toEvent() }
    }
    
    func loadEventDetails(for eventId: Int) async -> EventDetails? {
        var urlComponents = URLComponents(string: eventDetailsUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: "\(eventId)"),
            URLQueryItem(name: "ort", value: "true"),
            URLQueryItem(name: "attachements", value: "true")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return nil }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return nil }
        
        let ladvEvents = try! JSONDecoder().decode([LadvEventDetails].self, from: data)
        return ladvEvents.first?.toEventDetails()
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

private struct LadvEventDetails: Codable {
    let id: Int
    let name: String
    let ort: LadvEventLocation
    let sportstaette: String
    let datum: Int
    let attachements: [LadvEventAttachement]
    
    func toEventDetails() -> EventDetails {
        let dateMillis = datum
        let dateSeconds = Double(dateMillis) / 1000
        let date = Date(timeIntervalSince1970: dateSeconds)
        let location = EventLocation(name: ort.name, site: sportstaette, latitude: ort.lat, longitude: ort.lng)
        let attachements = attachements.compactMap { $0.toAttachement() }
        return EventDetails(id: id, name: name, date: date, location: location, attachements: attachements)
    }
}

private struct LadvEventLocation: Codable {
    let id: Int
    let name: String
    let lat: Double
    let lng: Double
}

private struct LadvEventAttachement: Codable {
    let name: String
    let url: String
    
    func toAttachement() -> Attachement? {
        guard let url = URL(string: url) else { return nil }
        return Attachement(name: name, url: url)
    }
}
