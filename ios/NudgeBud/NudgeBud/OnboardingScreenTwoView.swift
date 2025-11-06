//
//  OnboardingScreenTwoView.swift
//  NudgeBud
//
//  Created by OpenAI Assistant on 2024-xx-xx.
//

import SwiftUI

/// SwiftUI representation of the "Onboarding — screen 2" design.
/// The view leans heavily on the design tokens exported from Figma so the
/// visuals stay in sync with the product system. Inline comments call out the
/// rationale behind layout choices to keep future modifications approachable.
struct OnboardingScreenTwoView: View {
    /// `ColorScheme` drives dynamic styling such as background, text, and
    /// shadows. By relying on the environment we automatically react to system
    /// level appearance changes.
    @Environment(\.colorScheme) private var colorScheme

    /// `@ScaledMetric` keeps spacing comfortable when Dynamic Type is enabled.
    /// The base value mirrors the 24pt spacing from the design, but scales in a
    /// way that matches how Apple adjusts system components.
    @ScaledMetric(relativeTo: .body) private var verticalSpacing: CGFloat = 24

    var body: some View {
        ZStack {
            // Using the design system surface color means the screen seamlessly
            // fits with the rest of the app's backgrounds.
            DesignTokens.Colors.surface(for: colorScheme)
                .ignoresSafeArea()

            VStack(spacing: verticalSpacing) {
                progressIndicator

                VStack(alignment: .leading, spacing: 12) {
                    Text("Tune your nudges")
                        .font(.largeTitle).bold()
                        .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))
                        .multilineTextAlignment(.leading)

                    Text("Choose what you want gentle reminders for and we'll keep the momentum going.")
                        .font(.callout)
                        .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.75))
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                preferencesCard

                Spacer(minLength: 12)

                VStack(spacing: 16) {
                    // Navigation will be wired in a later story, so the action is
                    // intentionally left blank for now.
                    Button(action: {}) {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                    }
                    .buttonStyle(PrimaryButtonStyle())

                    // Secondary action is also a placeholder so QA can focus on
                    // layout and styling for this task.
                    Button(action: {}) {
                        Text("I'll do this later")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .foregroundColor(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.7))
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 48)
            .padding(.bottom, 32)
        }
    }

    /// Simple progress indicator showing that we are on step 2 of onboarding.
    private var progressIndicator: some View {
        HStack(spacing: 8) {
            Capsule()
                .fill(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.15))
                .frame(width: 28, height: 6)
            Capsule()
                .fill(DesignTokens.Colors.primary(for: colorScheme))
                .frame(width: 36, height: 6)
            Capsule()
                .fill(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.15))
                .frame(width: 28, height: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// The card displays a preview of the personalization options that are
    /// available after onboarding. Keeping the copy short prevents truncation on
    /// smaller accessibility sizes while still echoing the Figma design.
    private var preferencesCard: some View {
        let cardShadow = DesignTokens.Shadows.card(for: colorScheme)

        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Focus areas")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .textCase(.uppercase)
                    .kerning(0.8)
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.6))

                Text("Pick 3 to get started")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))
            }

            VStack(alignment: .leading, spacing: 12) {
                chipRow(labels: ["Wellness", "Deep work", "Budgeting"])
                chipRow(labels: ["Home", "Relationships", "Learning"])
            }

            Divider()
                .background(DesignTokens.Colors.outline(for: colorScheme))

            HStack(alignment: .center, spacing: 16) {
                Image(systemName: "bell.badge.fill")
                    .font(.title3)
                    .foregroundStyle(DesignTokens.Colors.primary(for: colorScheme))
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(DesignTokens.Colors.primary(for: colorScheme).opacity(0.15))
                    )

                Text("We’ll only nudge you during the hours you choose.")
                    .font(.footnote)
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.8))
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            DesignTokens.Colors.elevatedSurface(for: colorScheme)
        )
        .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radii.medium, style: .continuous))
        .shadow(color: cardShadow.color,
                radius: cardShadow.radius,
                x: cardShadow.x,
                y: cardShadow.y)
    }

    /// Helper that renders a horizontally wrapping row of pill-shaped chips.
    private func chipRow(labels: [String]) -> some View {
        HStack(spacing: 12) {
            ForEach(labels, id: \.self) { label in
                ChipView(title: label, isSelected: label != "Home")
            }
        }
    }
}

// MARK: - Supporting Views

/// Pill-shaped chip that mirrors the style from the design spec.
private struct ChipView: View {
    @Environment(\.colorScheme) private var colorScheme

    let title: String
    let isSelected: Bool

    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(background)
            .foregroundStyle(foreground)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(border, lineWidth: 1)
            )
    }

    /// Computed background color keeps the chip subtle when deselected and adds
    /// a bolder tint when selected.
    private var background: Color {
        if isSelected {
            return DesignTokens.Colors.chipSelectedBackground(for: colorScheme)
        } else {
            return DesignTokens.Colors.surface(for: colorScheme)
        }
    }

    /// Selected chips use the primary brand color, while deselected chips stay
    /// with the default surface foreground.
    private var foreground: Color {
        if isSelected {
            return DesignTokens.Colors.primary(for: colorScheme)
        } else {
            return DesignTokens.Colors.onSurface(for: colorScheme)
        }
    }

    /// Outline color becomes transparent for selected chips so the filled state
    /// feels softer, mimicking the Figma appearance.
    private var border: Color {
        if isSelected {
            return .clear
        } else {
            return DesignTokens.Colors.outline(for: colorScheme)
        }
    }
}

/// Custom button style that injects the brand color and ensures rounded
/// corners match the rest of the design language.
private struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(DesignTokens.Colors.onPrimary(for: colorScheme))
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: DesignTokens.Radii.medium, style: .continuous)
                    .fill(DesignTokens.Colors.primary(for: colorScheme))
                    .brightness(configuration.isPressed ? -0.1 : 0)
            )
            .clipShape(RoundedRectangle(cornerRadius: DesignTokens.Radii.medium, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: DesignTokens.Radii.medium, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview("Screen 2 · Light") {
    OnboardingScreenTwoView()
        .environment(\.colorScheme, .light)
}

#Preview("Screen 2 · Dark") {
    OnboardingScreenTwoView()
        .environment(\.colorScheme, .dark)
}
