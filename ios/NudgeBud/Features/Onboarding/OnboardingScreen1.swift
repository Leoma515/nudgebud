import SwiftUI

/// First screen in the onboarding sequence. The view is implemented directly
/// from the design spec and heavily commented so other teammates can quickly
/// understand the layout, modifiers, and accessibility affordances.
struct OnboardingScreen1: View {
    /// Closure fired when the primary CTA is pressed. Navigation is handled by
    /// the parent so previews and tests can inject lightweight stubs.
    let onNext: () -> Void

    /// `@ScaledMetric` keeps the major vertical rhythm aligned with Dynamic
    /// Type. The base value mirrors the spacing from the Figma spec, yet grows
    /// proportionally when fonts scale for accessibility.
    @ScaledMetric(relativeTo: .body) private var verticalSpacing: CGFloat = Tokens.Layout.verticalSpacing

    /// Button padding scales with Dynamic Type to preserve the minimum tap
    /// target when users enlarge text sizes in accessibility settings.
    @ScaledMetric(relativeTo: .body) private var buttonVerticalPadding: CGFloat = Tokens.Layout.buttonVerticalPadding

    var body: some View {
        ZStack {
            // Gradient background matches the design direction while
            // `ignoresSafeArea` ensures the color fills the full device canvas
            // (including the sensor housing and home indicator areas).
            LinearGradient(
                gradient: Gradient(colors: [Tokens.Colors.gradientTop, Tokens.Colors.gradientBottom]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: verticalSpacing) {
                // Leading spacer keeps the hero content visually centered even
                // on very tall devices like the iPhone 15 Pro Max.
                Spacer(minLength: Tokens.Layout.topSpacer)

                VStack(spacing: Tokens.Layout.contentSpacing) {
                    iconBadge

                    VStack(spacing: Tokens.Layout.textSpacing) {
                        Text("One tiny nudge at a time")
                            .font(.system(.largeTitle, design: .rounded).bold())
                            // Prevents the headline from compressing before the
                            // supporting copy when Dynamic Type is active.
                            .layoutPriority(1)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Tokens.Colors.primaryText)

                        Text("Build habits with approachable reminders that meet you where you are.")
                            .font(.system(.body, design: .rounded))
                            // Replicates the relaxed leading from the spec while
                            // remaining readable for assistive font sizes.
                            .lineSpacing(Tokens.Layout.bodyLineSpacing)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Tokens.Colors.secondaryText)
                            // Wider line limit prevents truncation on smaller
                            // devices while letting Dynamic Type reflow
                            // gracefully.
                            .lineLimit(nil)
                    }
                }
                // Expands content to the device width without breaking the
                // centered alignment of the text/icon stack.
                .frame(maxWidth: .infinity)

                Spacer()

                VStack(spacing: Tokens.Layout.bottomStackSpacing) {
                    pageControl

                    Button(action: {
                        // Forward the tap to the caller; no navigation logic is
                        // embedded here so the component stays reusable.
                        onNext()
                    }) {
                        Text("Next")
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            // Ensures at least the 44pt tap target required for
                            // comfortable thumb interaction.
                            .padding(.vertical, buttonVerticalPadding)
                    }
                    .background(Tokens.Colors.buttonBackground)
                    .foregroundStyle(Tokens.Colors.buttonForeground)
                    .clipShape(RoundedRectangle(cornerRadius: Tokens.Layout.buttonCornerRadius, style: .continuous))
                    // Extra shadow adds contrast against the gradient so the
                    // CTA remains easy to distinguish in both color schemes.
                    .shadow(color: Tokens.Colors.buttonShadow.opacity(0.24), radius: 18, x: 0, y: 8)
                    // VoiceOver label mirrors the visible text yet clarifies it
                    // advances the onboarding flow.
                    .accessibilityLabel(Text("Next onboarding step"))
                    .accessibilityHint(Text("Moves to the next screen in onboarding"))
                }
            }
            // Horizontal padding matches the mock and keeps the text readable on
            // wider layouts like landscape phones or iPad split view.
            .padding(.horizontal, Tokens.Layout.horizontalPadding)
            .padding(.bottom, Tokens.Layout.bottomPadding)
            // `maxWidth` centers the stack on iPad while retaining comfortable
            // line lengths on larger screens.
            .frame(maxWidth: Tokens.Layout.maxContentWidth)
            // Ensures VoiceOver reads the elements from top to bottom in the
            // same order that they appear visually.
            .accessibilityElement(children: .contain)
        }
    }

    /// Rounded badge with an SF Symbol that echoes the friendly iconography in
    /// the design. The translucent overlay gives the badge depth against the
    /// gradient while the comment explains how modifiers influence the look.
    private var iconBadge: some View {
        ZStack {
            Circle()
                .fill(Tokens.Colors.iconBackground)
                .frame(width: Tokens.Layout.iconDiameter, height: Tokens.Layout.iconDiameter)
                .overlay(
                    Circle()
                        .strokeBorder(Tokens.Colors.iconStroke, lineWidth: 1)
                        .blur(radius: 0.5)
                        .opacity(0.8)
                )
                .shadow(color: Tokens.Colors.iconShadow.opacity(0.32), radius: 22, x: 0, y: 14)

            Image(systemName: "sparkles")
                .font(.system(size: Tokens.Layout.iconSymbolSize, weight: .semibold, design: .rounded))
                .foregroundStyle(Tokens.Colors.primaryText)
                // Accessibility label explicitly describes the glyph for VoiceOver users.
                .accessibilityLabel(Text("Sparkling star icon"))
        }
        // Treat the badge and the symbol as a single accessibility element so
        // the icon is announced only once.
        .accessibilityElement(children: .combine)
    }

    /// Pagination control that indicates this is the first of three onboarding
    /// pages. The inactive dots use reduced opacity to meet contrast
    /// requirements without drawing focus away from the active state.
    private var pageControl: some View {
        HStack(spacing: Tokens.Layout.pageDotSpacing) {
            Circle()
                .fill(Tokens.Colors.pageDotActive)
                .frame(width: Tokens.Layout.pageDotSize, height: Tokens.Layout.pageDotSize)
            Circle()
                .fill(Tokens.Colors.pageDotInactive)
                .frame(width: Tokens.Layout.pageDotSize, height: Tokens.Layout.pageDotSize)
            Circle()
                .fill(Tokens.Colors.pageDotInactive)
                .frame(width: Tokens.Layout.pageDotSize, height: Tokens.Layout.pageDotSize)
        }
        // Group the dots for assistive technologies so they read as a single
        // progress element rather than three unrelated shapes.
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Page 1 of 3"))
    }
}

// MARK: - Preview

struct OnboardingScreen1_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingScreen1(onNext: {})
                .previewDisplayName("Light")
                .preferredColorScheme(.light)

            OnboardingScreen1(onNext: {})
                .previewDisplayName("Dark")
                .preferredColorScheme(.dark)

            OnboardingScreen1(onNext: {})
                .previewDisplayName("Light · Dynamic Type XL")
                .preferredColorScheme(.light)
                .environment(\.sizeCategory, .extraLarge)
        }
        .padding()
        // Previewing against a neutral background ensures the drop shadows and
        // gradient edges remain visible inside Xcode's preview canvas.
        .background(Color.black.opacity(0.05))
    }
}

// MARK: - Tokens

/// Local token namespace keeps the view self-contained until the shared design
/// system module is ready. The values match the hex codes provided by the
/// designers for the onboarding hero treatment.
private enum Tokens {
    enum Colors {
        static let gradientTop = Color(red: 109 / 255, green: 93 / 255, blue: 246 / 255)
        static let gradientBottom = Color(red: 62 / 255, green: 214 / 255, blue: 163 / 255)
        static let primaryText = Color.white
        static let secondaryText = Color.white.opacity(0.82)
        static let iconBackground = Color.white.opacity(0.12)
        static let iconStroke = Color.white.opacity(0.36)
        static let iconShadow = Color.black
        static let pageDotActive = Color.white
        static let pageDotInactive = Color.white.opacity(0.32)
        static let buttonBackground = Color.white
        static let buttonForeground = Color(red: 19 / 255, green: 25 / 255, blue: 45 / 255)
        static let buttonShadow = Color.black
    }

    enum Layout {
        static let verticalSpacing: CGFloat = 32
        static let contentSpacing: CGFloat = 24
        static let textSpacing: CGFloat = 12
        static let bodyLineSpacing: CGFloat = 6
        static let bottomStackSpacing: CGFloat = 20
        static let horizontalPadding: CGFloat = 32
        static let bottomPadding: CGFloat = 40
        static let topSpacer: CGFloat = 24
        static let maxContentWidth: CGFloat = 520
        static let buttonCornerRadius: CGFloat = 16
        static let buttonVerticalPadding: CGFloat = 16
        static let iconDiameter: CGFloat = 136
        static let iconSymbolSize: CGFloat = 52
        static let pageDotSize: CGFloat = 10
        static let pageDotSpacing: CGFloat = 12
    }
}
