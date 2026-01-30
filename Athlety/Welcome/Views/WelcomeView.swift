//
//  WelcomeView.swift
//  Athlety
//
//  Created by Stefan Lipp on 30.01.26.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack(alignment: .leading) {
                    header
                    features
                }
                .padding(.horizontal, 20)
            }
            Spacer()
            continueButton
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading) {
            Text("Welcome to")
                .font(.system(size: 44, weight: .bold))
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.4)
            Text("Athlety")
                .font(.system(size: 44, weight: .bold))
                .foregroundStyle(.accent.gradient)
        }
        .padding(.top, 80)
        .padding(.bottom, 40)
    }
    
    private var features: some View {
        VStack(alignment: .leading, spacing: 32) {
            feature(image: "square.stack", title: "Upcoming Events", description: "Get a quick overview about upcoming track and field events.")
            feature(image: "magnifyingglass", title: "Events Filter", description: "Apply custom event filters to only show events that match your preferences.")
            feature(image: "bookmark", title: "Bookamrks", description: "Save your favorite events as bookmarks for quick access.")
        }
        .padding(.bottom, 40)
    }
    
    @ViewBuilder
    private func feature(image: String, title: LocalizedStringKey, description: LocalizedStringKey) -> some View {
        HStack(alignment: .top, spacing: 24) {
            Image(systemName: image)
                .font(.system(size: 38, weight: .light))
                .foregroundStyle(.accent)
                .frame(width: 38, height: 38)
                .offset(y: 4)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                Text(description)
                    .font(.body)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private var continueButton: some View {
        Button {
            dismiss()
        } label: {
            HStack {
                Spacer()
                Text("Continue")
                    .fontWeight(.medium)
                    .padding(10)
                Spacer()
            }
        }
        .buttonStyle(.glassProminent)
        .padding(.horizontal, 20)
        .padding(.bottom, 24)
    }
}

#Preview {
    WelcomeView()
}
