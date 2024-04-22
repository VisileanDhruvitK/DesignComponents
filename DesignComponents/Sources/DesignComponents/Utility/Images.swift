//
//  Images.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 05/09/23.
//

import Foundation
import UIKit

extension UIImage {
    
    static let radio = VLImage(named: "radio")
    static let radioSelected = VLImage(named: "radio_selected")
    static let radio_XL = VLImage(named: "radio_XL")
    
    static let radioSelected_XL = VLImage(named: "radio_selected_XL")
    
    static let checkBox = VLImage(named: "checkBox")
    static let checkBoxSelected = VLImage(named: "checkBox_selected")
    static let checkBoxIndeterminant = VLImage(named: "checkBox_indeterminant")
    
    static let checkBox_XL = VLImage(named: "checkBox_XL")
    static let checkBoxSelected_XL = VLImage(named: "checkBox_selected_XL")
    static let checkBoxIndeterminant_XL = VLImage(named: "checkBox_indeterminant_XL")
    
    static let arrowDown = VLImage(named: "arrowDown")
    public static let user_Image = VLImage(named: "user_Image")
    
    static let toggleOn = VLImage(named: "toggle_on")
    static let toggleOnDisabled = VLImage(named: "toggle_on_disabled")
    static let toggleOff = VLImage(named: "toggle_off")
    static let toggleOffDIsabled = VLImage(named: "toggle_off_disabled")
    
    static let toggleOn_XL = VLImage(named: "toggle_on_XL")
    static let toggleOnDisabled_XL = VLImage(named: "toggle_on_disabled_XL")
    static let toggleOff_XL = VLImage(named: "toggle_off_XL")
    static let toggleOffDIsabled_XL = VLImage(named: "toggle_off_disabled_XL")
    
    static let inputDropdown = VLImage(named: "inputDropdown")
    static let percentageDown = VLImage(named: "percentageDown")
    
    static let infoIcon = VLImage(named: "infoIcon")
}


func VLImage(named name: String) -> UIImage? {
    UIImage(named: name, in: Bundle.module, compatibleWith: nil)
}
