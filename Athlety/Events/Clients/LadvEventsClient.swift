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
            URLQueryItem(name: "attachements", value: "true"),
            URLQueryItem(name: "wettbewerbe", value: "true")
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
    let wettbewerbe: [LadvEventDiscipline]
    
    func toEventDetails() -> EventDetails {
        return EventDetails(
            id: id,
            name: name,
            date: date,
            note: beschreibung.isEmpty ? nil : beschreibung,
            location: location,
            registration: registration,
            links: links.compactMap { $0.toLink() },
            attachements: attachements.compactMap { $0.toAttachement() },
            disciplines: wettbewerbe.compactMap { $0.toDiscipline() }
        )
    }
    
    private var date: Date {
        let dateMillis = datum
        let dateSeconds = Double(dateMillis) / 1000
        return Date(timeIntervalSince1970: dateSeconds)
    }
    
    private var location: EventLocation {
        EventLocation(name: ort.name, site: sportstaette, latitude: ort.lat, longitude: ort.lng)
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

private struct LadvEventDiscipline: Codable {
    let disziplinNew: String
    let klasseNew: String
    
    var discipline: Discipline? {
        switch disziplinNew {
        case "L30": .sprint30m
        case "L40": .sprint40m
        case "L50": .sprint50m
        case "L60": .sprint60m
        case "L75": .sprint75m
        case "L80": .sprint80m
        case "L100": .sprint100m
        case "L150": .sprint150m
        case "L200": .sprint200m
        case "L300": .sprint300m
        case "L400": .sprint400m
        
        case "L500": .running500m
        case "L600": .running600m
        case "L800": .running800m
        case "L1K5": .running1500m
        case "L2K0": .running2000m
        case "L3K0": .running3000m
        case "L5K0": .running5000m

        case "H60_0600",
             "H60_0686",
             "H60_0762",
             "H60_0838",
             "H60_0914",
             "H60_0991",
             "H60_1067": .hurdles60m
            
        case "H100": .hurdles100m
        case "H110": .hurdles110m
        case "H400": .hurdles400m
            
        case "THOC": .highJump
        case "TWEI": .longJump
        case "TSTA": .poleVault
            
        case "TKUG_7260": .shotPut
        case "TSPE_0800": .javelinThrow
        
        case "THAM_3000",
             "THAM_4000",
             "THAM_6000",
             "THAM_7260": .hammerThrow
            
        case "M4K": .quadrathlon
        case "M5K": .pentathlon
            
        case "KKILA": .childrensAthletics
            
        case "SCR": .crossCountry
            
        default: nil
        }
    }
    
    func toDiscipline() -> EventDiscipline? {
        guard let discipline else { return nil }
        return EventDiscipline(discipline: discipline, ageGroup: klasseNew)
    }
}
