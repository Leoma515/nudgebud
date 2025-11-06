import SwiftUI

/// Helper extension that allows initializing `Color` instances with hex strings.
extension Color {
    /// Creates a `Color` from a hex string such as "#FFFFFF".
    /// This initializer supports both three and six character RGB codes.
    init(hex: String) {
        // Remove any character that is not 0-9 or A-F so we can safely parse the value.
        let filtered = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: filtered).scanHexInt64(&value)

        // Expand three digit hex strings (e.g. FFF) into the six digit variant (FFFFFF).
        if filtered.count == 3 {
            let digits = filtered.map { String(repeating: String($0), count: 2) }.joined()
            Scanner(string: digits).scanHexInt64(&value)
        }

        let r, g, b: Double
        if filtered.count == 6 {
            r = Double((value & 0xFF0000) >> 16) / 255.0
            g = Double((value & 0x00FF00) >> 8) / 255.0
            b = Double(value & 0x0000FF) / 255.0
        } else {
            // Fallback to white in case of unexpected input.
            r = 1.0
            g = 1.0
            b = 1.0
        }

        self.init(red: r, green: g, blue: b)
    }
}

/// Centralized palette powered by the values stored in `design/tokens.json`.
/// Using this type keeps the SwiftUI views agnostic of the actual hex strings.
enum ThemeColor {
    /// Background color for the surface layer of the onboarding experience.
    static func surface(for scheme: ColorScheme) -> Color {
        Color(hex: scheme == .dark ? "#0F1115" : "#F7F8FA")
    }

    /// Elevated surface color used for cards and chips.
    static func surfaceElevated(for scheme: ColorScheme) -> Color {
        Color(hex: scheme == .dark ? "#1A1D22" : "#FFFFFF")
    }

    /// Primary brand color for accent elements.
    static func primary(for scheme: ColorScheme) -> Color {
        Color(hex: scheme == .dark ? "#7C87FF" : "#5B6EFF")
    }

    /// Color applied to text that sits on top of the surface background.
    static func onSurface(for scheme: ColorScheme) -> Color {
        Color(hex: scheme == .dark ? "#E9ECF2" : "#0F1115")
    }

    /// Background color for the highlighted state of feature chips.
    static func chipSelectedBackground(for scheme: ColorScheme) -> Color {
        Color(hex: scheme == .dark ? "#2A2F3A" : "#E9ECFF")
    }
}
