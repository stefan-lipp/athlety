//
//  AssociationsClient.swift
//  Athlety
//
//  Created by Stefan Cimander on 19.05.23.
//

import Foundation

protocol AssociationsClient {
    func loadAssociations() async -> [Association]
}
