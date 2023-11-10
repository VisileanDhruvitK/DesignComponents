//
//  Appearance.swift
//  
//
//  Created by VisiLean Admin on 08/09/23.
//

import Foundation
import UIKit

struct Appearance {
    
    var backgroundColor: UIColor = .white
    var borderWidth: CGFloat = 0
    var borderColor: UIColor = .clear
    var cornerRadius: CGFloat = 0
    
    init(backgroundColor: UIColor = .clear, borderWidth: CGFloat = 0, borderColor: UIColor = .clear, cornerRadius: CGFloat = 0) {
        self.backgroundColor = backgroundColor
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
    }
    
}

extension Appearance {
    
    static let primaryButton = Appearance(backgroundColor: .primary_5, cornerRadius: 10)
    static let primaryButtonDisabled = Appearance(backgroundColor: .neutral_0_5, cornerRadius: 10)
    
    static let secondaryButton = Appearance(borderWidth: 1, borderColor: .neutral_1_5, cornerRadius: 10)
    static let secondaryButtonDisabled = Appearance(borderWidth: 1, borderColor: .neutral_1_5, cornerRadius: 10)
    
    static let secondaryImageButton = Appearance(backgroundColor: .primary_0_5, cornerRadius: 10)
    static let secondaryImageButtonDisabled = Appearance(backgroundColor: .neutral_0_5, cornerRadius: 10)
    
}

struct Appearances {
    var enableUI: Appearance = Appearance()
    var disableUI: Appearance = Appearance()
}

extension Appearances {
    
    static let primaryButton = Appearances(enableUI: .primaryButton, disableUI: .primaryButtonDisabled)
    static let secondaryButton = Appearances(enableUI: .secondaryButton, disableUI: .secondaryButtonDisabled)
    static let secondaryImageButton = Appearances(enableUI: .secondaryImageButton, disableUI: .secondaryImageButtonDisabled)
    
}
