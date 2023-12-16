//
//  MenuTabShape.swift
//  ITU
//
//  Created by Nikita Pasynkov
//

import SwiftUI

/// `MenuTabShape` represents the custom shape used for the menu tab.
struct MenuTabShape: Shape {
    // The value used to determine the location of the curve in the shape
    var midpoint: CGFloat
    
    // Property used for animation
    var animatableData: CGFloat {
        get { midpoint }
        set { midpoint = newValue }
    }

    /// Function that draw the path for the MenuTabShape
    /// - Parameter rect: The rectangular bounds used to draw the shape.
    /// - Returns: A path that represents the Menu Tab Shape.
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.addPath(Rectangle().path(in: rect))
            
            path.move(to: .init(x: midpoint - 60, y: 0))
            
            let to = CGPoint(x: midpoint, y: -25)
            let control1 = CGPoint(x: midpoint - 25, y: 0)
            let control2 = CGPoint(x: midpoint - 25, y: -25)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            
            let to1 = CGPoint(x: midpoint + 60, y: 0)
            let control3 = CGPoint(x: midpoint + 25, y: -25)
            let control4 = CGPoint(x: midpoint + 25, y: 0)
            
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}
