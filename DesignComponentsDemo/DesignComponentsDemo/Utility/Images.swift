//
//  Images.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 15/09/23.
//

import Foundation
import UIKit

extension UIImage {
    
    // static let arrowDown = VLImage(named: "arrowDown")
    
}


func VLImage(named name: String) -> UIImage? {
    UIImage(named: name, in: Bundle.main, compatibleWith: nil)
}
