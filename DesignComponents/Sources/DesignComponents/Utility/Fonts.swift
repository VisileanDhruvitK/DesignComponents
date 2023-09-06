//
//  Fonts.swift
//  DesignComponentsDemo
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import Foundation
import UIKit

public enum FontSize: CGFloat {
    case font12 = 12
    case font14 = 14
    case font16 = 16
}

extension UIFont {
    
    static let formItemTitle = VLFont(size: .font16, weigth: .medium)
    static let formItemText = UIFont.systemFont(ofSize: 16, weight: .regular)
    
    static let primaryButtonTitle = UIFont.systemFont(ofSize: 12, weight: .semibold)
    static let secondaryButtonTitle = UIFont.systemFont(ofSize: 12, weight: .semibold)
    
    static let radioButton = UIFont.systemFont(ofSize: 14, weight: .medium)
    static let checkBox = UIFont.systemFont(ofSize: 14, weight: .medium)
    
}

public func VLFont(size: FontSize, weigth: UIFont.Weight) -> UIFont {
    UIFont.systemFont(ofSize: size.rawValue, weight: weigth)
}
