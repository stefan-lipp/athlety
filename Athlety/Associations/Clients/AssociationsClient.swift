//
//  AssociationsClient.swift
//  Athlety
//
//  Created by Stefan Lipp on 29.06.25.
//

import Foundation

nonisolated protocol AssociationsClient: Sendable {
    func loadAssociations() async -> [Association]
}
