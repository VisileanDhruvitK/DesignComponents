//
//  Fonts.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import Foundation
import UIKit

enum FontSize: CGFloat {
    case font12 = 12
    case font14 = 14
    case font16 = 16
}

extension UIFont {
    
    static let font12Regular = VLFont(size: .font12, weigth: .regular)
    static let font12Medium = VLFont(size: .font12, weigth: .medium)
    static let font12Semibold = VLFont(size: .font12, weigth: .semibold)
    static let font12Bold = VLFont(size: .font12, weigth: .bold)
    
    static let font14Regular = VLFont(size: .font14, weigth: .regular)
    static let font14Medium = VLFont(size: .font14, weigth: .medium)
    static let font14Semibold = VLFont(size: .font14, weigth: .semibold)
    static let font14Bold = VLFont(size: .font14, weigth: .bold)
    
    static let font16Regular = VLFont(size: .font16, weigth: .regular)
    static let font16Medium = VLFont(size: .font16, weigth: .medium)
    static let font16Semibold = VLFont(size: .font16, weigth: .semibold)
    static let font16Bold = VLFont(size: .font16, weigth: .bold)
    
}

func VLFont(size: FontSize, weigth: UIFont.Weight) -> UIFont {
    UIFont.systemFont(ofSize: size.rawValue, weight: weigth)
}
