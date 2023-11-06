//
//  File.swift
//  
//
//  Created by VisiLean Admin on 15/09/23.
//

import Foundation

/**
 Component Size
 1. s - Small
 2. m - Medium
 3. l - Large
 4. xl - Extra Large
 5. xxl - 2X Large
 */
public enum ComponentSize {
    case small
    case medium
    case large
    case xl
    case xxl
}

/**
 Selection State
 1. Deselected
 2. Indeterminant
 3. Selected
 */
public enum SelectionState {
    case deselected
    case indeterminant
    case selected
}
