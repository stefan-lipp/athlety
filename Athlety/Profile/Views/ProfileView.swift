//
//  ProfileView.swift
//  Athlety
//
//  Created by Stefan Lipp on 14.10.23.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel
    
    var body: some View {
        Text("\(viewModel.profile?.firstName ?? "") \(viewModel.profile?.lastName ?? "")")
            .task { await viewModel.loadProfile(with: Config.shared.ladvProfileId) }
    }
}

#Preview {
    ProfileView()
}
