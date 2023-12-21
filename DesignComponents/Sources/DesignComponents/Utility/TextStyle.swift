//
//  TextStyle.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import Foundation
import UIKit

struct TextStyle {
    
    var font: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    var color: UIColor = .black
    var textAlignment: NSTextAlignment = .left
    
    init(font: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium), color: UIColor = .black, textAlignment: NSTextAlignment = .left) {
        self.font = font
        self.color = color
        self.textAlignment = textAlignment
    }
    
}

extension TextStyle {
    
    static let formTitle = TextStyle(font: .font16Medium, color: .formItemTitle)
    static let formTextField = TextStyle(font: .font16Regular, color: .formItemText)
    
    static let primaryButton = TextStyle(font: .font12Semibold, color: .white)
    static let primaryButtonDisabled = TextStyle(font: .font12Semibold, color: .primary_3)
    
    static let secondaryButton = TextStyle(font: .font12Semibold, color: .neutral_7)
    static let secondaryButtonDisabled = TextStyle(font: .font12Semibold, color: .neutral_3)
    
    static let linkButton = TextStyle(font: .font14Semibold, color: .primary_6)
    static let linkButtonDisabled = TextStyle(font: .font14Semibold, color: .neutral_3)
    
    static let secondaryImageButton = TextStyle(font: .font16Semibold, color: .primary_6, textAlignment: .center)
    static let secondaryImageButtonDisabled = TextStyle(font: .font16Semibold, color: .neutral_3, textAlignment: .center)
    
    static let radioButton = TextStyle(font: .font14Medium, color: .primary_7)
    static let radioButtonDisabled = TextStyle(font: .font14Medium, color: .primary_2)
    
    static let checkBoxTitle = TextStyle(font: .font14Medium, color: .primary_7)
    static let checkBoxSubTitle = TextStyle(font: .font14Regular, color: .neutral_7)
    
    static let toggleTitle = TextStyle(font: .font14Medium, color: .primary_7)
    static let toggleSubTitle = TextStyle(font: .font14Medium, color: .neutral_7)
    
    static let chipTitlePA = TextStyle(font: .font14Medium, color: .neutral_7)
    static let chipDisabledPA = TextStyle(font: .font14Medium, color: .neutral_4)
    
    static let chipTitleSU = TextStyle(font: .font14Medium, color: .primary_6)
    static let chipDisabledSU = TextStyle(font: .font14Medium, color: .neutral_4)
}

struct TextStyles {
    var enableUI: TextStyle = TextStyle()
    var disableUI: TextStyle = TextStyle()
    
    init(enableUI: TextStyle = TextStyle(), disableUI: TextStyle = TextStyle()) {
        self.enableUI = enableUI
        self.disableUI = disableUI
    }
    
}

extension TextStyles {
    
    static let linkButton = TextStyles(enableUI: .linkButton, disableUI: .linkButtonDisabled)
    static let primaryButton = TextStyles(enableUI: .primaryButton, disableUI: .primaryButtonDisabled)
    static let secondaryButton = TextStyles(enableUI: .secondaryButton, disableUI: .secondaryButtonDisabled)
    static let secondaryImageButton = TextStyles(enableUI: .secondaryImageButton, disableUI: .secondaryImageButtonDisabled)
}
