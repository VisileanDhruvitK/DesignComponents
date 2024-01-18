//
//  File.swift
//  
//
//  Created by VisiLean Admin on 18/01/24.
//

import Foundation
import UIKit

extension String {
    
    func addRedStar(starColor: UIColor = .destructive_5, textColor: UIColor = .primary_7) -> NSMutableAttributedString {
        let redStar = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.foregroundColor : starColor])
        
        let attributedReasons = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.foregroundColor : textColor])
        attributedReasons.append(redStar)
        return attributedReasons
    }
    
}
