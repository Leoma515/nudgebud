//
//  DesignTokens.swift
//  NudgeBud
//
//  Created by OpenAI Assistant on 2024-xx-xx.
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
    }
}
