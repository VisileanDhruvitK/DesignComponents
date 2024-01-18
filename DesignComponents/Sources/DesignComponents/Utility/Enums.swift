//
//  Enums.swift
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

/**
 Direction
 1. Top
 2. Left
 3. Bottom
 4. Right
 */
public enum Direction {
    case top
    case left
    case bottom
    case right
}

/**
 Radius Type
 1. Round
 2. Rounded Rectangle
 3. Square
 */
public enum RadiusType {
    case round
    case roundedRect
    case square
}
