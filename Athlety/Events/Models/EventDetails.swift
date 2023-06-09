//
//  EventDetails.swift
//  Athlety
//
//  Created by Stefan Cimander on 01.06.23.
//

import Foundation

struct EventDetails: Identifiable {
    let id: Int
    let name: String
    let location: String
    let address: String
    let date: Date
    
    let attachements: [Attachement]
    let disciplines: [Discipline]
}
