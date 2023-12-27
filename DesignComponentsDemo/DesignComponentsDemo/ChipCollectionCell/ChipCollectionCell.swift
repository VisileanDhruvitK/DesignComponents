//
//  ChipCollectionCell.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 21/12/23.
//

import UIKit
import DesignComponents

class ChipCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var chipControl: ChipControl!
    @IBOutlet weak var chipControlHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(title: String, isSelected: Bool, size: ComponentSize = .medium, chipStyle: ChipStyle = .roundPA) {
        chipControl.componentSize = size
        
        let option = ChipOption(title: title, isSelected: isSelected, chipType: .textOnly, chipStyle: chipStyle)
        chipControl.setOption(option: option)
        chipControl.isUserInteractionEnabled = false
        setHeight(height: (size == .medium ? 40 : 32))
    }
    
    func configureCell(option: ChipOption, size: ComponentSize = .medium) {
        chipControl.componentSize = size
        chipControl.setOption(option: option)
        chipControl.isUserInteractionEnabled = false
        setHeight(height: (size == .medium ? 40 : 32))
    }
    
    func setHeight(height: CGFloat) {
        chipControlHeight.constant = height
        self.chipControl.layoutIfNeeded()
    }
    
}
