//
//  ContentView.swift
//  NudgeBud
//
//  Created by Jerry Moffett on 11/5/25.
//

import SwiftUI

/// Acts as an integration point for the Onboarding screen that was implemented
/// for this milestone. As the app evolves this view can be swapped with a more
/// complete flow coordinator, but for now the focus is on matching the Figma
/// mock.
struct ContentView: View {
    var body: some View {
        OnboardingScreenTwoView()
    }
}

#Preview {
    ContentView()
}
