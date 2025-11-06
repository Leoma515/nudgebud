//
//  DesignTokens.swift
//  NudgeBud
//
//  Created by OpenAI Assistant on 2024-xx-xx.
//  Created by OpenAI's ChatGPT on 11/5/25.
//

import SwiftUI

/// A lightweight namespace that exposes the design tokens exported from Figma.
/// Keeping these in code makes it easy to stay in sync with the design system
/// while still benefiting from type safety and code completion in SwiftUI.
enum DesignTokens {
    enum Colors {
        /// Returns the surface/background color that should be used for the
        /// supplied color scheme. The light and dark values come from
        /// `design/tokens.json`.
        static func surface(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color(hex: "#0F1115") : Color(hex: "#F7F8FA")
        }

        /// Elevated surfaces are used for floating cards and modals.
        static func elevatedSurface(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color(hex: "#1A1D22") : Color(hex: "#FFFFFF")
        }

        /// Primary brand color used for key actions.
        static func primary(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color(hex: "#7C87FF") : Color(hex: "#5B6EFF")
        }

        /// Foreground color for text that sits on top of the primary color.
        static func onPrimary(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color(hex: "#0B0C10") : Color(hex: "#FFFFFF")
        }

        /// Base foreground color for text that sits on a neutral surface.
        static func onSurface(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color(hex: "#E9ECF2") : Color(hex: "#0F1115")
        }

        /// Outline color used for subtle strokes and separators.
        static func outline(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark
                ? Color(hex: "#FFFFFF", alpha: 0.16)
                : Color(hex: "#000000", alpha: 0.12)
        }

        /// Background color for the selected state of pill-shaped chips.
        static func chipSelectedBackground(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? Color(hex: "#2A2F3A") : Color(hex: "#E9ECFF")
enum DesignTokens {
    enum Colors {
        static let surfaceLight = Color(red: 247/255, green: 248/255, blue: 250/255)
        static let surfaceDark = Color(red: 15/255, green: 17/255, blue: 21/255)
        static let surfaceElevatedLight = Color(red: 1, green: 1, blue: 1)
        static let surfaceElevatedDark = Color(red: 26/255, green: 29/255, blue: 34/255)
        static let onSurfaceLight = Color(red: 15/255, green: 17/255, blue: 21/255)
        static let onSurfaceDark = Color(red: 233/255, green: 236/255, blue: 242/255)
        static let primaryLight = Color(red: 91/255, green: 110/255, blue: 255/255)
        static let primaryDark = Color(red: 124/255, green: 135/255, blue: 255/255)
        static let onPrimaryLight = Color(red: 255/255, green: 255/255, blue: 255/255)
        static let onPrimaryDark = Color(red: 11/255, green: 12/255, blue: 16/255)
        static let outlineLight = Color.black.opacity(0.12)
        static let outlineDark = Color.white.opacity(0.16)
        static let chipSelectedBgLight = Color(red: 233/255, green: 236/255, blue: 255/255)
        static let chipSelectedBgDark = Color(red: 42/255, green: 47/255, blue: 58/255)

        static func surface(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? surfaceDark : surfaceLight
        }

        static func surfaceElevated(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? surfaceElevatedDark : surfaceElevatedLight
        }

        static func onSurface(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? onSurfaceDark : onSurfaceLight
        }

        static func primary(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? primaryDark : primaryLight
        }

        static func onPrimary(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? onPrimaryDark : onPrimaryLight
        }

        static func outline(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? outlineDark : outlineLight
        }

        static func chipSelectedBackground(for colorScheme: ColorScheme) -> Color {
            colorScheme == .dark ? chipSelectedBgDark : chipSelectedBgLight
        }
    }

    enum Radii {
        /// Rounded corner radius used for medium emphasis components like cards.
        static let medium: CGFloat = 16
    }

    enum Shadows {
        /// Shadow used for elevated cards. The values are translated from the
        /// CSS-like token definition in `design/tokens.json`.
        static func card(for colorScheme: ColorScheme) -> (color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
            if colorScheme == .dark {
                return (Color.black.opacity(0.60), 6, 0, 2)
            } else {
                return (Color.black.opacity(0.14), 6, 0, 2)
            }
        }
    }
}

// MARK: - Color helper

extension Color {
    /// Convenience initializer that converts a hex string (e.g. "#FFFFFF")
    /// into a SwiftUI `Color`. The optional `alpha` parameter makes it easy to
    /// override transparency when token strings use RGBA values.
    init(hex: String, alpha: Double? = nil) {
        // Remove the leading `#` if it exists and normalize the string.
        var normalized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        // Expand shorthand hex values like `#FFF` into `#FFFFFF` so that the
        // scanner logic below can treat every channel uniformly.
        if normalized.count == 3 {
            normalized = normalized.reduce(into: "") { partialResult, character in
                partialResult.append(String(repeating: character, count: 2))
            }
        }

        var int: UInt64 = 0
        Scanner(string: normalized).scanHexInt64(&int)

        let r, g, b: Double
        switch normalized.count {
        case 6:
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8) & 0xFF) / 255
            b = Double(int & 0xFF) / 255
        default:
            r = 1
            g = 1
            b = 1
        }

        let resolvedAlpha = alpha ?? 1

        self.init(.sRGB, red: r, green: g, blue: b, opacity: resolvedAlpha)
        static let medium: CGFloat = 16
    }

    enum Layout {
        static let maxContentWidth: CGFloat = 480
    }
}

extension View {
    func onboardingCardShadow(colorScheme: ColorScheme) -> some View {
        shadow(color: colorScheme == .dark ? Color.black.opacity(0.6) : Color.black.opacity(0.14), radius: 12, x: 0, y: 6)
    }
}
