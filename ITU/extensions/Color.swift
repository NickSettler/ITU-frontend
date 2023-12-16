//
//  Color.swift
//  Finance App
//
//  Created by Elena Marochkina
//

import Foundation
import SwiftUI

/// Color extension to provide application specific colors and helper functions for hex conversions.
extension Color {
    static var theme: Color  {
        return Color("theme")
    }
    
    static var BackgroundColor: Color  {
        return Color("BackgroundColor")
    }
    
    static var BackgroundColorList: Color  {
        return Color("BackgroundColorList")
    }
    
    static var Accent: Color  {
        return Color("AccentColor")
    }
    
    static var TextColorPrimary: Color  {
        return Color("TextColorPrimary")
    }
    
    static var TextColorSecondary: Color  {
        return Color("TextColorSecondary")
    }
    
    static var Primary50: Color  {
        return Color("Primary50")
    }
    
    static var Primary100: Color  {
        return Color("Primary100")
    }
    
    static var Primary200: Color  {
        return Color("Primary200")
    }
    
    static var Primary300: Color  {
        return Color("Primary300")
    }
    
    static var Primary400: Color  {
        return Color("Primary400")
    }
    
    static var Primary500: Color  {
        return Color("Primary500")
    }
    
    static var Primary600: Color  {
        return Color("Primary600")
    }
    
    static var Primary700: Color  {
        return Color("Primary700")
    }
    
    static var Secondary50: Color  {
        return Color("Secondary50")
    }
    
    static var Secondary100: Color  {
        return Color("Secondary100")
    }
    
    static var Secondary200: Color  {
        return Color("Secondary200")
    }
    
    static var Secondary300: Color  {
        return Color("Secondary300")
    }
    
    static var Secondary400: Color  {
        return Color("Secondary400")
    }
    
    static var Secondary500: Color  {
        return Color("Secondary500")
    }
    
    static var Secondary600: Color  {
        return Color("Secondary600")
    }
    
    static var Secondary700: Color  {
        return Color("Secondary700")
    }
    
    static var Grey50: Color  {
        return Color("Grey50")
    }
    
    static var Grey100: Color  {
        return Color("Grey100")
    }
    
    static var Grey00: Color  {
        return Color("Grey200")
    }
    
    static var Grey300: Color  {
        return Color("Grey300")
    }
    
    static var Grey400: Color  {
        return Color("Grey400")
    }
    
    static var Grey500: Color  {
        return Color("Grey500")
    }
    
    static var Grey600: Color  {
        return Color("Grey600")
    }
    
    static var Grey700: Color  {
        return Color("Grey700")
    }

    static var Tertiary100: Color  {
        return Color("Tertiary100")
    }
    
    static var Tertiary200: Color  {
        return Color("Tertiary200")
    }
    
    static var Tertiary300: Color  {
        return Color("Tertiary300")
    }
    
    static var Tertiary400: Color  {
        return Color("Tertiary400")
    }
    
    static var Tertiary500: Color  {
        return Color("Tertiary500")
    }
    
    static var Tertiary600: Color  {
        return Color("Tertiary600")
    }
    
    static var Tertiary700: Color  {
        return Color("Tertiary700")
    }
    
    static var Quaternary100: Color  {
        return Color("Quaternary100")
    }
    
    static var Quaternary200: Color  {
        return Color("Quaternary200")
    }
    
    static var Quaternary300: Color  {
        return Color("Quaternary300")
    }
    
    static var Quaternary400: Color  {
        return Color("Quaternary400")
    }
    
    static var Quaternary500: Color  {
        return Color("Quaternary500")
    }
    
    static var Quaternary600: Color  {
        return Color("Quaternary600")
    }
    
    static var Quaternary700: Color  {
        return Color("Quaternary700")
    }

	// Various static properties that return named colors.

  	/// Initialize Color from a hex value.
  	///
    /// - Parameters:
	///   - hex: Unsigned integer of the hex value.
    ///   - alpha: The opacity of the color. Defaults to 1.
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            opacity: alpha
        )
    }

	/// Get color components
    /// - Returns: Color components
    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
        
        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }

	/// Get hex from color
    /// - Returns: Hex
    func toHex() -> UInt? {
        let components = self.components()
        
        let r = Int(components.r * 255) << 16
        let g = Int(components.g * 255) << 8
        let b = Int(components.b * 255)
        
        return UInt(r + g + b)
    }
}
