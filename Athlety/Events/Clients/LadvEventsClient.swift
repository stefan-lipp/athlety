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
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return [] }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }
        
        let ladvEvents = try! JSONDecoder().decode([LadvEvent].self, from: data)
        return ladvEvents.map(toEvent)
    }
    
    func loadEventDetails(for eventId: Int) async -> EventDetails? {
        var urlComponents = URLComponents(string: eventDetailsUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "id", value: "\(eventId)"),
            URLQueryItem(name: "ort", value: "true"),
            URLQueryItem(name: "attachements", value: "true"),
            URLQueryItem(name: "wettbewerbe", value: "true")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return nil }
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
        return EventDetails(
            id: ladvEvent.id,
            name: ladvEvent.name,
            date: date,
            location: toEventLocation(ladvEvent),
            registration: toEventRegistration(ladvEvent),
            attachements: ladvEvent.attachements.compactMap(toAttachement),
            disciplines: []
        )
    }
    
    private func toEventLocation(_ ladvEvent: LadvEventDetails) -> EventLocation {
        return EventLocation(
            name: ladvEvent.ort.name,
            site: ladvEvent.sportstaette,
            latitude: ladvEvent.ort.lat,
            longitude: ladvEvent.ort.lng
        )
    }
    
    private func toEventRegistration(_ ladvEvent: LadvEventDetails) -> EventRegistration {
        let deadlineMillis = ladvEvent.meldDatum
        let deadlineSeconds = Double(deadlineMillis) / 1000
        let deadline = Date(timeIntervalSince1970: deadlineSeconds)
        return EventRegistration(
            deadline: deadline,
            email: ladvEvent.meldEmail
        )
    }
    
    private func toAttachement(_ ladvAttachement: LadvEventAttachement) -> Attachement? {
        guard let url = URL(string: ladvAttachement.url + "?file=true") else { return nil }
        return Attachement(
            name: ladvAttachement.name,
            url: url,
            type: ladvAttachement.fileExtension == ".pdf" ? .pdf : .unknown(extension: ladvAttachement.fileExtension)
        )
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
        
        let meldEmail: String
        let meldDatum: Int
        
        let attachements: [LadvEventAttachement]
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
        let fileExtension: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case url
            case fileExtension = "extension"
        }
    }
}
