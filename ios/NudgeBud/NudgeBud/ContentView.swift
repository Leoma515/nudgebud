//
//  ContentView.swift
//  NudgeBud
//
//  Created by Jerry Moffett on 11/5/25.
//

import SwiftUI

/// Serves as the app's root view by presenting the onboarding flow that greets
/// new users when NudgeBud launches. Future navigation stacks can replace the
/// onboarding view without needing to touch the rest of the scene setup.
struct ContentView: View {
    var body: some View {
        OnboardingView()
    }
}

#Preview("Onboarding · Light") {
    ContentView()
        .preferredColorScheme(.light)
}

#Preview("Onboarding · Dark") {
    ContentView()
        .preferredColorScheme(.dark)
}
