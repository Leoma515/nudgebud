//
//  OnboardingScreenThreeView.swift
//  NudgeBud
//
//  Created by OpenAI Assistant on 2024-xx-xx.
//

import SwiftUI

/// SwiftUI representation of the "Onboarding — screen 3" concept. The layout
/// mirrors the Figma mock by layering decorative shapes behind a celebratory
/// badge and reinforcing the accountability message with feature chips.
struct OnboardingScreenThreeView: View {
    @Environment(\.colorScheme) private var colorScheme

    /// Data backing the feature chips displayed near the bottom of the screen.
    private let chipLabels: [String] = [
        "Shared schedules",
        "Gentle reminders",
        "Celebrate wins"
    ]

    var body: some View {
        ZStack {
            DesignTokens.Colors.surface(for: colorScheme)
                .ignoresSafeArea()

            VStack(spacing: 28) {
                header

                illustration

                messaging

                featureChips

                Spacer(minLength: 0)

                callToAction

                pagination
            }
            .padding(.horizontal, 28)
            .padding(.top, 56)
            .padding(.bottom, 36)
        }
    }

    /// Top portion showing the onboarding progress and dismiss control.
    private var header: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))
                    .padding(12)
                    .background(
                        Circle()
                            .fill(DesignTokens.Colors.surfaceElevated(for: colorScheme).opacity(0.7))
                    )
            }
            .buttonStyle(.plain)

            Spacer()

            ProgressIndicator(
                currentStep: 3,
                totalSteps: 3,
                activeColor: DesignTokens.Colors.primary(for: colorScheme),
                inactiveColor: DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.2)
            )

            Spacer()

            Button("Skip") {}
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.7))
        }
    }

    /// Custom illustration composed of gradient capsules and the app icon.
    private var illustration: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        colors: [DesignTokens.Colors.primary(for: colorScheme).opacity(0.35), .clear],
                        center: .center,
                        startRadius: 0,
                        endRadius: 160
                    )
                )
                .frame(width: 240, height: 240)

            RoundedRectangle(cornerRadius: 32, style: .continuous)
                .fill(DesignTokens.Colors.surfaceElevated(for: colorScheme))
                .frame(width: 220, height: 180)
                .rotationEffect(.degrees(-12))
                .shadow(color: .black.opacity(colorScheme == .dark ? 0.5 : 0.14), radius: 24, y: 12)

            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(DesignTokens.Colors.surfaceElevated(for: colorScheme))
                .frame(width: 190, height: 150)
                .rotationEffect(.degrees(8))
                .offset(x: 18, y: 14)
                .overlay(alignment: .topLeading) {
                    Label(
                        title: { Text("Shared Nudges").font(.system(size: 14, weight: .semibold)) },
                        icon: {
                            Image(systemName: "person.2.fill")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundStyle(DesignTokens.Colors.primary(for: colorScheme))
                        }
                    )
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))
                    .padding(16)
                }
                .overlay(alignment: .bottomTrailing) {
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Win logged!")
                            .font(.system(size: 13, weight: .semibold))
                        Text("You both completed the daily walk.")
                            .font(.system(size: 11, weight: .regular))
                            .multilineTextAlignment(.trailing)
                    }
                    .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))
                    .padding(14)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(DesignTokens.Colors.surface(for: colorScheme).opacity(0.85))
                    )
                    .padding(18)
                }

            Image(systemName: "sparkles")
                .font(.system(size: 48, weight: .bold))
                .foregroundStyle(DesignTokens.Colors.primary(for: colorScheme))
                .offset(y: -96)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
    }

    /// Title and supporting copy pulled from the product brief.
    private var messaging: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Stay accountable together")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme))
                .multilineTextAlignment(.leading)

            Text("NudgeBud keeps partners in sync with gentle prompts, shared wins, and encouragement that matches your energy.")
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.75))
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// Highlight pills showcasing what makes this step unique.
    private var featureChips: some View {
        WrapLayout(spacing: 12, lineSpacing: 12) {
            ForEach(chipLabels, id: \.self) { label in
                Text(label)
                    .font(.system(size: 15, weight: .semibold))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(
                        Capsule(style: .continuous)
                            .fill(DesignTokens.Colors.chipSelectedBackground(for: colorScheme))
                    )
                    .foregroundStyle(DesignTokens.Colors.primary(for: colorScheme))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    /// Button visitors can tap once they feel ready to continue past onboarding.
    private var callToAction: some View {
        Button(action: {}) {
            Text("Jump in")
                .font(.system(size: 17, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .foregroundStyle(DesignTokens.Colors.onPrimary(for: colorScheme))
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(DesignTokens.Colors.primary(for: colorScheme))
                )
        }
        .buttonStyle(.plain)
    }

    /// Pagination dots conveying the user's current position in the onboarding flow.
    private var pagination: some View {
        HStack(spacing: 8) {
            ForEach(1...3, id: \.self) { index in
                Capsule(style: .continuous)
                    .fill(
                        index == 3
                            ? DesignTokens.Colors.primary(for: colorScheme)
                            : DesignTokens.Colors.onSurface(for: colorScheme).opacity(0.2)
                    )
                    .frame(width: index == 3 ? 36 : 8, height: 8)
            }
        }
        .padding(.top, 12)
    }
}

#Preview("Screen 3 · Light") {
    OnboardingScreenThreeView()
        .environment(\.colorScheme, .light)
}

#Preview("Screen 3 · Dark") {
    OnboardingScreenThreeView()
        .environment(\.colorScheme, .dark)
}

// MARK: - Supporting Views

/// Visual indicator that renders a segmented progress bar.
private struct ProgressIndicator: View {
    let currentStep: Int
    let totalSteps: Int
    let activeColor: Color
    let inactiveColor: Color

    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...totalSteps, id: \.self) { step in
                Capsule(style: .continuous)
                    .fill(step <= currentStep ? activeColor : inactiveColor)
                    .frame(width: step == currentStep ? 32 : 14, height: 8)
                    .animation(.easeInOut(duration: 0.25), value: currentStep)
            }
        }
    }
}

/// Layout that automatically wraps its content horizontally before moving to the next row.
private struct WrapLayout: Layout {
    var spacing: CGFloat = 8
    var lineSpacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let arrangement = arrangement(proposal: proposal, subviews: subviews)
        return arrangement.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let arrangement = arrangement(proposal: ProposedViewSize(width: bounds.width, height: proposal.height), subviews: subviews)
        for index in subviews.indices {
            let origin = CGPoint(x: bounds.minX + arrangement.positions[index].x,
                                 y: bounds.minY + arrangement.positions[index].y)
            let size = arrangement.sizes[index]
            subviews[index].place(
                at: origin,
                proposal: ProposedViewSize(width: size.width, height: size.height)
            )
        }
    }

    private func arrangement(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, positions: [CGPoint], sizes: [CGSize]) {
        let maxWidth = proposal.width ?? .infinity
        let lineLimit = maxWidth == .infinity || maxWidth == 0 ? CGFloat.greatestFiniteMagnitude : maxWidth

        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        var maxWidthUsed: CGFloat = 0

        var positions: [CGPoint] = []
        var sizes: [CGSize] = []

        for subview in subviews {
            let size = subview.sizeThatFits(ProposedViewSize(width: lineLimit, height: nil))
            let requiredWidth = size.width

            if currentX > 0 && currentX + spacing + requiredWidth > lineLimit {
                currentX = 0
                currentY += lineHeight + lineSpacing
                lineHeight = 0
            }

            positions.append(CGPoint(x: currentX, y: currentY))
            sizes.append(size)

            maxWidthUsed = max(maxWidthUsed, currentX + requiredWidth)
            currentX += requiredWidth + spacing
            lineHeight = max(lineHeight, size.height)
        }

        let totalHeight = currentY + lineHeight
        let finalWidth = min(lineLimit, maxWidthUsed)

        return (CGSize(width: finalWidth, height: totalHeight), positions, sizes)
    }
}
