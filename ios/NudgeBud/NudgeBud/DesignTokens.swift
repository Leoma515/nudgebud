//
//  DesignTokens.swift
//  NudgeBud
//
//  Created by OpenAI's ChatGPT on 11/5/25.
//

import SwiftUI

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
