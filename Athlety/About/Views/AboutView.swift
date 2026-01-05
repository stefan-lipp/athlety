//
//  AboutView.swift
//  Athlety
//
//  Created by Stefan Lipp on 05.01.26.
//

import SwiftUI

struct AboutView: View {
    
    var body: some View {
        ScrollView {
            VStack {
                appIcon
                title
                versionText
                Spacer()
            }
        }
    }
    
    private var appIcon: some View {
        Image("AthletyAppIcon")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .frame(maxWidth: 128)
            .padding()
    }
    
    private var title: some View {
        Text("Athlety")
            .font(.largeTitle)
            .fontWeight(.semibold)
    }
    
    @ViewBuilder
    private var versionText: some View {
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        Text("v\(version)")
            .font(.subheadline)
    }
}

#Preview {
    AboutView()
}
