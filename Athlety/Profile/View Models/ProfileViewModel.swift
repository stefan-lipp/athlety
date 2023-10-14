//
//  ProfileViewModel.swift
//  Athlety
//
//  Created by Stefan Lipp on 14.10.23.
//

import SwiftUI

@MainActor
class ProfileViewModel: ObservableObject {
    
    @Published var profile: Profile?
    
    private let client: ProfileClient = LadvProfileClient()
    
    func loadProfile(with profileId: Int) async {
        profile = await client.loadProfile(with: profileId)
    }
}
