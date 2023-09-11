//
//  Images.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 05/09/23.
//

import Foundation
import UIKit

public extension UIImage {
    
    static let radio = VLImage(named: "radio")
    static let radioSelected = VLImage(named: "radio_selected")
    
    static let checkBox = VLImage(named: "checkBox")
    static let checkBoxSelected = VLImage(named: "checkBox_selected")
    
    static let arrowDown = VLImage(named: "arrowDown")
    
    static let toggleOn = VLImage(named: "toggle_on")
    static let toggleOnDisabled = VLImage(named: "toggle_on_disabled")
    static let toggleOff = VLImage(named: "toggle_off")
    static let toggleOffDIsabled = VLImage(named: "toggle_off_disabled")
}


public func VLImage(named name: String) -> UIImage? {
    UIImage(named: name, in: Bundle.module, compatibleWith: nil)
}
