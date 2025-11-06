//
//  OnboardingView.swift
//  NudgeBud
//
//  Created by OpenAI's ChatGPT on 11/5/25.
//

import SwiftUI

/// Presents the marketing-oriented onboarding experience that introduces the
/// core value propositions before a user signs in or creates a nudge.
struct OnboardingView: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            // We fill the background with the surface color so the view
            // seamlessly matches the design token palette in both themes.
            DesignTokens.Colors.surface(for: colorScheme)
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    heroCard
                    copySection
                    actionButton
                    secondaryAction
                }
                // Keeping the layout centered and readable on large iPads.
                .frame(maxWidth: DesignTokens.Layout.maxContentWidth, alignment: .center)
                .padding(.horizontal, 24)
                .padding(.vertical, 48)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }

    private var heroCard: some View {
        ZStack {
            // Elevated surface uses a rounded rectangle to echo the figma card.
            RoundedRectangle(cornerRadius: DesignTokens.Radii.medium, style: .continuous)
                .fill(DesignTokens.Colors.surfaceElevated(for: colorScheme))
                .overlay(
                    // A subtle border prevents the card from blending into the background.
                    RoundedRectangle(cornerRadius: DesignTokens.Radii.medium, style: .continuous)
                        .stroke(DesignTokens.Colors.outline(for: colorScheme))
                )

            VStack(alignment: .leading, spacing: 16) {
                OnboardingHeroIllustration()
                    .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 8) {
                    Text("All your nudges in one calm place")
                        .font(.title2.bold())
                        .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))

                    Text("Plan gentle reminders, share progress with your accountability crew, and celebrate wins without the noise.")
                        .font(.body)
                        .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.72))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(28)
        }
        .onboardingCardShadow(colorScheme: colorScheme)
    }

    private var copySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Why you’ll love NudgeBud")
                .font(.headline)
                .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))

            VStack(alignment: .leading, spacing: 12) {
                featureRow(icon: "bell.badge", title: "Thoughtful nudges", detail: "Schedule reminders that respect focus time and avoid overload.")
                featureRow(icon: "person.2.fill", title: "Shared journeys", detail: "Loop in friends for accountability and see progress at a glance.")
                featureRow(icon: "sparkle.magnifyingglass", title: "Celebrate growth", detail: "Capture reflections so every tiny win gets the spotlight it deserves.")
            }
        }
    }

    private var actionButton: some View {
        Button(action: {}) {
            // Using maxWidth ensures the button feels prominent on the first screen.
            Text("Create my first nudge")
                .font(.headline)
                .foregroundStyle(DesignTokens.Colors.onPrimary(for: colorScheme))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(DesignTokens.Colors.primary(for: colorScheme))
                )
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("onboarding_primary_cta")
    }

    private var secondaryAction: some View {
        Button(action: {}) {
            Text("I’ll explore first")
                .font(.subheadline)
                .foregroundStyle(DesignTokens.Colors.primary(for: colorScheme))
        }
        .buttonStyle(.plain)
        .padding(.top, -12)
    }

    private func featureRow(icon: String, title: String, detail: String) -> some View {
        HStack(alignment: .top, spacing: 16) {
            // The icon sits on a chip background that adapts between light and dark.
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(DesignTokens.Colors.primary(for: colorScheme))
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(DesignTokens.Colors.chipSelectedBackground(for: colorScheme))
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.bold())
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))

                Text(detail)
                    .font(.footnote)
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.72))
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

#Preview("Onboarding – Light") {
    OnboardingView()
        .preferredColorScheme(.light)
}

#Preview("Onboarding – Dark") {
    OnboardingView()
        .preferredColorScheme(.dark)
}

private struct OnboardingHeroIllustration: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            Circle()
                .fill(DesignTokens.Colors.primary(for: colorScheme).opacity(0.18))
                .frame(width: 160, height: 160)
                .offset(x: 40, y: -40)

            RoundedRectangle(cornerRadius: 120, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [DesignTokens.Colors.primary(for: colorScheme), DesignTokens.Colors.primary(for: colorScheme).opacity(0.4)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 220, height: 180)
                .rotationEffect(.degrees(-12))

            Image(systemName: "sparkles")
                .font(.system(size: 42, weight: .semibold))
                .foregroundStyle(DesignTokens.Colors.onPrimary(for: colorScheme))
                .padding(20)
                .background(
                    Circle().fill(DesignTokens.Colors.primary(for: colorScheme))
                )
                .shadow(color: DesignTokens.Colors.primary(for: colorScheme).opacity(0.35), radius: 12, x: 0, y: 10)
        }
    }
}
