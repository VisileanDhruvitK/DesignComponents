//
//  Models.swift
//  
//
//  Created by VisiLean Admin on 18/01/24.
//

import Foundation
import UIKit

// Image Option
public struct ImageOption {
    public var image: UIImage? = nil
    public var color: UIColor? = nil
    public var borderColor: UIColor? = nil
    public var borderWidth: CGFloat = 0
    public var cornerRadius: CGFloat = 0
    public var radiusType: RadiusType = .square
    
    public init(image: UIImage? = nil, color: UIColor? = nil, borderColor: UIColor? = nil, borderWidth: CGFloat = 0, cornerRadius: CGFloat = 0, radiusType: RadiusType = .square) {
        self.image = image
        self.color = color
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.radiusType = radiusType
    }
    
}
