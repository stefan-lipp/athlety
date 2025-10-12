//
//  AssociationsClient.swift
//  Athlety
//
//  Created by Stefan Lipp on 29.06.25.
//

import Foundation

protocol AssociationsClient {
    func loadAssociations() async -> [Association]
}
