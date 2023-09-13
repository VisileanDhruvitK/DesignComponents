//
//  TextStyle.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import Foundation
import UIKit

public struct TextStyle {
    
    var font: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    var color: UIColor = .black
    var textAlignment: NSTextAlignment = .left
    
    init(font: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium), color: UIColor = .black, textAlignment: NSTextAlignment = .left) {
        self.font = font
        self.color = color
        self.textAlignment = textAlignment
    }
    
}

public extension TextStyle {
    
    static let formTitle = TextStyle(font: .formItemTitle, color: .formItemTitle)
    static let formTextField = TextStyle(font: .formItemText, color: .formItemText)
    
    static let primaryButton = TextStyle(font: .primaryButtonTitle, color: .white)
    static let primaryButtonDisabled = TextStyle(font: .primaryButtonTitle, color: .primary_3)
    
    static let secondaryButton = TextStyle(font: .secondaryButtonTitle, color: .neutral_7)
    static let secondaryButtonDisabled = TextStyle(font: .secondaryButtonTitle, color: .neutral_3)
    
    static let linkButton = TextStyle(font: .linkButtonTitle, color: .primary_6)
    static let linkButtonDisabled = TextStyle(font: .linkButtonTitle, color: .neutral_3)
    
    static let secondaryImageButton = TextStyle(font: .secondaryImageButtonTitle, color: .primary_6, textAlignment: .center)
    static let secondaryImageButtonDisabled = TextStyle(font: .secondaryImageButtonTitle, color: .neutral_3, textAlignment: .center)
    
    static let radioButton = TextStyle(font: .radioButton, color: .primary_7)
    static let radioButtonDisabled = TextStyle(font: .radioButton, color: .primary_2)
    
    static let checkBox = TextStyle(font: .checkBox, color: .primary_7)
    static let checkBoxDisabled = TextStyle(font: .checkBox, color: .primary_2)
    
    static let toggleTitle = TextStyle(font: .toggleTitle, color: .neutral_8_5)
    static let toggleSubTitle = TextStyle(font: .toggleSubTitle, color: .neutral_7)
    
    static let chipTitle = TextStyle(font: .chipTitle, color: .primary_7)
    static let chipDisabled = TextStyle(font: .chipTitle, color: .primary_2)
}

public struct TextStyles {
    var enableUI: TextStyle = TextStyle()
    var disableUI: TextStyle = TextStyle()
    
    init(enableUI: TextStyle = TextStyle(), disableUI: TextStyle = TextStyle()) {
        self.enableUI = enableUI
        self.disableUI = disableUI
    }
    
}

public extension TextStyles {
    
    static let linkButton = TextStyles(enableUI: .linkButton, disableUI: .linkButtonDisabled)
    static let primaryButton = TextStyles(enableUI: .primaryButton, disableUI: .primaryButtonDisabled)
    static let secondaryButton = TextStyles(enableUI: .secondaryButton, disableUI: .secondaryButtonDisabled)
    static let secondaryImageButton = TextStyles(enableUI: .secondaryImageButton, disableUI: .secondaryImageButtonDisabled)
}
