//
//  ProfileClient.swift
//  Athlety
//
//  Created by Stefan Lipp on 14.10.23.
//

import Foundation

protocol ProfileClient {
    
    func loadProfile(with profileId: Int) async -> Profile?
    
}
