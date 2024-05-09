//
//  ProfileView.swift
//  Athlety
//
//  Created by Stefan Lipp on 14.10.23.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        NavigationStack {
            Text(verbatim: "")
                .navigationTitle("Your Profile")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ProfileView()
}
