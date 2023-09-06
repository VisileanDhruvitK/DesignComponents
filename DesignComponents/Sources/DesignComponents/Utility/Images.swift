//
//  Images.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 05/09/23.
//

import Foundation
import UIKit

public extension UIImage {
    
    static let radio = VLImage(named: "radio")
    static let radioSelected = VLImage(named: "radio_selected")
    
    static let checkBox = VLImage(named: "checkBox")
    static let checkBoxSelected = VLImage(named: "checkBox_selected")
    
}


public func VLImage(named name: String) -> UIImage? {
    UIImage(named: name, in: Bundle.module, compatibleWith: nil)
}
