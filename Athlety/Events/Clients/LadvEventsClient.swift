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
        
        let ladvEvents = try? JSONDecoder().decode([LadvEvent].self, from: data)
        return ladvEvents?.compactMap { $0.toEvent() } ?? []
    }
    
    func loadEventDetails(for eventId: Int) async -> EventDetails? {
        var urlComponents = URLComponents(string: eventDetailsUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: "\(eventId)"),
            URLQueryItem(name: "ort", value: "true"),
            URLQueryItem(name: "links", value: "true"),
            URLQueryItem(name: "attachements", value: "true")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return nil }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return nil }
        
        let ladvEvents = try? JSONDecoder().decode([LadvEventDetails].self, from: data)
        return ladvEvents?.first?.toEventDetails()
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
    let beschreibung: String
    let ort: LadvEventLocation
    let sportstaette: String
    let datum: Int
    let meldEmail: String
    let meldDatum: Int
    let links: [LadvEventLink]
    let attachements: [LadvEventAttachement]
    
    func toEventDetails() -> EventDetails {
        let note = beschreibung.isEmpty ? nil : beschreibung
        let location = EventLocation(name: ort.name, site: sportstaette, latitude: ort.lat, longitude: ort.lng)
        let links = links.compactMap { $0.toLink() }
        let attachements = attachements.compactMap { $0.toAttachement() }
        return EventDetails(id: id, name: name, date: date, note: note, location: location, registration: registration, links: links, attachements: attachements)
    }
    
    private var date: Date {
        let dateMillis = datum
        let dateSeconds = Double(dateMillis) / 1000
        return Date(timeIntervalSince1970: dateSeconds)
    }
    
    private var registration: EventRegistration {
        let deadlineMillis = meldDatum
        let deadlineSeconds = Double(deadlineMillis) / 1000
        let deadline = Date(timeIntervalSince1970: deadlineSeconds)
        return EventRegistration(deadline: deadline, email: meldEmail)
    }
}

private struct LadvEventLocation: Codable {
    let id: Int
    let name: String
    let lat: Double
    let lng: Double
}

private struct LadvEventLink: Codable {
    let name: String
    let url: String
    
    func toLink() -> EventLink? {
        guard let url = URL(string: url) else { return nil }
        return EventLink(name: name, url: url)
    }
}

private struct LadvEventAttachement: Codable {
    let name: String
    let url: String
    
    func toAttachement() -> EventAttachement? {
        guard let url = URL(string: url + "?file=true") else { return nil }
        return EventAttachement(name: name, url: url)
    }
}
