//
//  ContentView.swift
//  NudgeBud
//
//  Created by Jerry Moffett on 11/5/25.
//

import SwiftUI

/// Acts as the integration point for the onboarding experience that was
/// implemented for this milestone. As additional navigation is introduced this
/// view can evolve into a flow coordinator, but for now it simply hosts the
/// opening screen showcased in the Figma handoff.
struct ContentView: View {
    var body: some View {
        OnboardingView()
    }
}

#Preview("Onboarding · Light") {
    ContentView()
        .environment(\.colorScheme, .light)
}

#Preview("Onboarding · Dark") {
    ContentView()
        .environment(\.colorScheme, .dark)
}
