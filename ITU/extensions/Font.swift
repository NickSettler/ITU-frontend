//
//  Font.swift
//  ITU
//
//  Created by Nikita on 18.11.2023.
//

import Foundation
import SwiftUI

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

extension Font {
    static func custom(_ font: JetBrainsMono, relativeTo style: Font.TextStyle) -> Font {
        custom(font.rawValue, size: style.size, relativeTo: style)
    }
    
    static let mono = custom(JetBrainsMono.light.rawValue, size: 16)
}
