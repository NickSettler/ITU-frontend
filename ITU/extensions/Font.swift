//
//  Font.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import Foundation
import SwiftUI

/// Enum `JetBrainsMono` represents the types of JetBrains Mono font.
enum JetBrainsMono: String {
    case regular = "JetBrainsMono-Regular"
    case italic = "JetBrainsMono-Italic"
    case medium = "JetBrainsMono-Medium"
    case mediumItalic = "JetBrainsMono-MediumItalic"
    case bold = "JetBrainsMono-Bold"
    case boldItalic = "JetBrainsMono-BoldItalic"
    case extraBold = "JetBrainsMono-ExtraBold"
    case extraBoldItalic = "JetBrainsMono-ExtraBoldItalic"
    case light = "JetBrainsMono-Light"
    case lightItalic = "JetBrainsMono-LightItalic"
    case extraLight = "JetBrainsMono-ExtraLight"
    case extraLightItalic = "JetBrainsMono-ExtraLightItalic"
    case thin = "JetBrainsMono-Thin"
    case thinItalic = "JetBrainsMono-ThinItalic"
}

/// Extension of `Font.TextStyle` to calculate font sizes.
extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle: return 60
        case .title: return 48
        case .title2: return 34
        case .title3: return 24
        case .headline, .body: return 18
        case .subheadline, .callout: return 16
        case .footnote: return 14
        case .caption, .caption2: return 12
        @unknown default:
            return 8
        }
    }
}

/// Main font name
fileprivate let helveticaFont = "Helvetica"

/// Font extension to define custom fonts in the app.
extension Font {

	/// Creates a custom font
	/// - Parameters:
    ///   - name: Font name
    ///   - size: Font size
    ///   - relativeTo: Style relative to
    static func custom(_ font: JetBrainsMono, relativeTo style: Font.TextStyle) -> Font {
        custom(font.rawValue, size: style.size, relativeTo: style)
    }

	// Set of predefined custom fonts
    static let mono = custom(JetBrainsMono.light.rawValue, size: 16)
    
    static let helvetica16 = custom(helveticaFont, size: 16)
    static let helvetica22 = custom(helveticaFont, size: 22)
    static let helvetica30 = custom(helveticaFont, size: 30)
}
