//
//  ContentView.swift
//  NudgeBud
//
//  Created by Jerry Moffett on 11/5/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        OnboardingView()
    }
}

#Preview("Light") {
    ContentView()
        .environment(\.colorScheme, .light)
}

#Preview("Dark") {
    ContentView()
        .environment(\.colorScheme, .dark)
}
