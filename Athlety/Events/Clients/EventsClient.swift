//
//  LadvEventsClient.swift
//  Athlety
//
//  Created by Stefan Cimander on 16.05.23.
//

import Foundation

class EventsClient {
    
    // TODO: Avoid hardcoded URL
    private let ladvEventsUrl = URL(string: "https://ladv.de/api/{apiKey}/ausList?lv=BY&mostCurrent=true&limit=200")!
    
    func loadUpcomingEvents() async -> [Event] {
        let request = URLRequest(url: ladvEventsUrl)
        let (data, response) = try! await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return [] }
        let ladvEvents = try! JSONDecoder().decode([LadvEvent].self, from: data)
        return ladvEvents.map(toEvent)
    }
    
    private func toEvent(_ ladvEvent: LadvEvent) -> Event {
        let dateSeconds = Double(ladvEvent.datum) / 1000
        return Event(id: ladvEvent.id, name: ladvEvent.name, location: ladvEvent.ort, date: Date(timeIntervalSince1970: dateSeconds))
    }
    
    private struct LadvEvent: Codable {
        let id: Int
        let name: String
        let ort: String
        let datum: Int
    }
    
}
