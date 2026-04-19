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
    
    func loadUpcomingEvents(for associationId: String?, and discipline: Discipline?) async -> [Event] {
        var urlComponents = URLComponents(string: eventsUrl)!
        urlComponents.queryItems = [
            URLQueryItem(name: "mostCurrent", value: "true"),
            URLQueryItem(name: "limit", value: "200")
        ]
        if let associationId {
            urlComponents.queryItems?.append(URLQueryItem(name: "lv", value: associationId))
        }
        if let discipline {
            urlComponents.queryItems?.append(URLQueryItem(name: "disziplin", value: discipline.disziplin))
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
    let isCancelled: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, ort, datum
        case isCancelled = "abgesagt"
    }

    func toEvent() -> Event {
        Event(id: id, name: name, location: ort, date: date, isCancelled: isCancelled ?? false)
    }
    
    private var date: Date {
        let dateMillis = datum
        let dateSeconds = Double(dateMillis) / 1000
        return Date(timeIntervalSince1970: dateSeconds)
    }
}

private struct LadvEventDetails: Codable {
    let id: Int
    let name: String
    let note: String
    let isCancelled: Bool?
    let ort: LadvEventLocation
    let site: String
    let datum: Int
    let meldEmail: String
    let meldDatum: Int
    let host: String
    let url: String
    let links: [LadvEventLink]
    let attachments: [LadvEventAttachment]
    let disciplines: [LadvEventDiscipline]

    private enum CodingKeys: String, CodingKey {
        case id, name, ort, datum, meldEmail, meldDatum, url, links
        case isCancelled = "abgesagt"
        case host = "ausrichter"
        case note = "beschreibung"
        case site = "sportstaette"
        case attachments = "attachements"
        case disciplines = "wettbewerbe"
    }

    func toEventDetails() -> EventDetails {
        EventDetails(
            id: id,
            name: name,
            date: date,
            isCancelled: isCancelled ?? false,
            note: note.isEmpty ? nil : note,
            location: location,
            url: URL(string: url),
            registration: registration,
            links: links.compactMap { $0.toLink() },
            attachments: attachments.compactMap { $0.toAttachment() },
            disciplines: disciplines.compactMap { $0.toDiscipline() }
        )
    }
    
    private var date: Date {
        let dateMillis = datum
        let dateSeconds = Double(dateMillis) / 1000
        return Date(timeIntervalSince1970: dateSeconds)
    }
    
    private var location: EventLocation {
        EventLocation(name: ort.name, site: site, latitude: ort.lat, longitude: ort.lng)
    }
    
    private var registration: EventRegistration {
        let deadlineMillis = meldDatum
        let deadlineSeconds = Double(deadlineMillis) / 1000
        let deadline = Date(timeIntervalSince1970: deadlineSeconds)
        return EventRegistration(host: host, email: meldEmail, deadline: deadline)
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

private struct LadvEventAttachment: Codable {
    let name: String
    let url: String
    
    func toAttachment() -> EventAttachment? {
        guard let url = URL(string: url + "?file=true") else { return nil }
        return EventAttachment(name: name, url: url)
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
        case "L1K0": .running1000m
        case "L5K0": .running5000m
        case "L10K": .running10000m
        
        case "SHAL": .halfMarathon
        case "SMAR": .marathon
        case "SL", "SLK", "SLL": .roadRunning
        case "SCR": .crossCountry

        case "H60", "H60_0600", "H60_0686", "H60_0762", "H60_0838", "H60_0914", "H60_0991", "H60_1067": .hurdles60m
        case "H80", "H80_0600", "H80_0686", "H80_0762", "H80_0838", "H80_0914": .hurdles80m
        case "H100", "H100_0686", "H100_0762", "H100_0838", "H100_0914": .hurdles100m
        case "H110", "H110_0686", "H110_0762", "H110_0838", "H110_0914", "H110_0991", "H110_1067": .hurdles110m
        case "H400", "H400_0762", "H400_0838", "H400_0914": .hurdles400m

        case "H1K5", "H1K5_0762": .steeplechase1500m
        case "H2K0", "H2K0_0762", "H2K0_0838", "H2K0_0914": .steeplechase2000m
        case "H3K0", "H3K0_0762", "H3K0_0914": .steeplechase3000m

        case "THOC": .highJump
        case "TWEI": .longJump
        case "TDRE": .tripleJump
        case "TSTA": .poleVault

        case "TBAL_0200": .ballThrow
        case "TKUG", "TKUG_2000", "TKUG_3000", "TKUG_4000", "TKUG_5000", "TKUG_6000", "TKUG_7260": .shotPut
        case "TDIS", "TDIS_0750", "TDIS_1000", "TDIS_1500", "TDIS_1750", "TDIS_2000": .discusThrow
        case "TSPE", "TSPE_0400", "TSPE_0500", "TSPE_0600", "TSPE_0700", "TSPE_0800": .javelinThrow
        case "THAM", "THAM_2000", "THAM_3000", "THAM_4000", "THAM_5000", "THAM_6000", "THAM_7260": .hammerThrow

        case "X4X5": .relay4x50m
        case "X4X7": .relay4x75m
        case "X4X1": .relay4x100m
        case "X4X4": .relay4x400m
        case "X3X8": .relay3x800m
        case "X3X1": .relay3x1000m

        case "M3K": .triathlon
        case "M4K": .quadrathlon
        case "M5K": .pentathlon
        case "M6K": .hexathlon
        case "M7K": .heptathlon
        case "M8K": .octathlon
        case "M10K": .decathlon

        case "MBLS": .blockSprint
        case "MBLL": .blockRun
        case "MBLW": .blockThrow
        case "MBLM": .blockTeam

        case "KKILA": .childrensAthletics

        default: nil
        }
    }
    
    func toDiscipline() -> EventDiscipline? {
        guard let discipline else { return nil }
        return EventDiscipline(discipline: discipline, ageGroup: klasseNew)
    }
}

extension Discipline {
    
    var disziplin: String {
        switch self {
            
        case .sprint30m: "30"
        case .sprint40m: "40"
        case .sprint50m: "50"
        case .sprint60m: "60"
        case .sprint75m: "75"
        case .sprint80m: "80"
        case .sprint100m: "100"
        case .sprint150m: "150"
        case .sprint200m: "200"
        case .sprint300m: "300"
        case .sprint400m: "400"
            
        case .running500m: "500"
        case .running600m: "600"
        case .running800m: "800"
        case .running1000m: "1K0"
        case .running1500m: "1K5"
        case .running2000m: "2K0"
        case .running3000m: "3K0"
        case .running5000m: "5K0"
        case .running10000m: "10K"
        
        case .halfMarathon: "HAL"
        case .marathon: "MAR"
        case .roadRunning: "SL"
        case .crossCountry: "CROS"
        
        case .hurdles60m: "60H"
        case .hurdles80m: "80H"
        case .hurdles100m: "100H"
        case .hurdles110m: "110H"
        case .hurdles400m: "400H"

        case .steeplechase1500m: "1K5H"
        case .steeplechase2000m: "2K0H"
        case .steeplechase3000m: "3K0H"

        case .relay4x50m: "4X5"
        case .relay4x75m: "4X7"
        case .relay4x100m: "4X1"
        case .relay4x400m: "4X4"
        case .relay3x800m: "3X8"
        case .relay3x1000m: "3X1"
        
        case .highJump: "HOC"
        case .longJump: "WEI"
        case .tripleJump: "DRE"
        case .poleVault: "STA"
        
        case .ballThrow: "SCH"
        case .shotPut: "KUG"
        case .discusThrow: "DIS"
        case .javelinThrow: "SPE"
        case .hammerThrow: "HAM"
        
        case .triathlon: "3-K"
        case .quadrathlon: "4-K"
        case .pentathlon: "5-K"
        case .hexathlon: "6-K"
        case .heptathlon: "7-K"
        case .octathlon: "8-K"
        case .nonathlon: "9-K"
        case .decathlon: "10-K"

        case .blockSprint: "BLS"
        case .blockRun: "BLL"
        case .blockThrow: "BLW"
        case .blockTeam: "BLM"

        case .childrensAthletics: "KILA"
        }
    }
}
