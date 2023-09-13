//
//  Fonts.swift
//  DesignComponents
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
    static let formItemText = VLFont(size: .font16, weigth: .regular)
    
    static let primaryButtonTitle = VLFont(size: .font12, weigth: .semibold)
    static let secondaryButtonTitle = VLFont(size: .font12, weigth: .semibold)
    static let linkButtonTitle = VLFont(size: .font14, weigth: .semibold)
    static let secondaryImageButtonTitle = VLFont(size: .font16, weigth: .semibold)
    
    static let radioButton = VLFont(size: .font14, weigth: .medium)
    static let checkBox = VLFont(size: .font14, weigth: .medium)
    
    static let toggleTitle = VLFont(size: .font14, weigth: .medium)
    static let toggleSubTitle = VLFont(size: .font14, weigth: .regular)
    
    static let chipTitle = VLFont(size: .font14, weigth: .medium)
}

public func VLFont(size: FontSize, weigth: UIFont.Weight) -> UIFont {
    UIFont.systemFont(ofSize: size.rawValue, weight: weigth)
}
