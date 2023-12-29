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
    
    func configureCell(image: UIImage? = nil, title: String, buttonImage: UIImage? = nil, isSelected: Bool = false, isEnabled: Bool = true, chipType: ChipType = .textOnly, chipStyle: ChipStyle = .roundPA, size: ComponentSize = .medium) {
        let option = ChipOption(image: image, title: title, buttonImage: buttonImage, isSelected: isSelected, chipType: chipType, chipStyle: chipStyle)
        chipControl.setOption(option: option)
        chipControl.componentSize = size
        
        if chipType == .withButton || chipType == .withImageAndButton {
            chipControl.isUserInteractionEnabled = true
        } else {
            chipControl.isUserInteractionEnabled = false
        }
        
        setChipHeight(height: (size == .medium ? 40 : 32))
    }
    
    func configureCell(option: ChipOption, size: ComponentSize = .medium) {
        chipControl.setOption(option: option)
        chipControl.componentSize = size
        
        if option.chipType == .withButton || option.chipType == .withImageAndButton {
            chipControl.isUserInteractionEnabled = true
        } else {
            chipControl.isUserInteractionEnabled = false
        }
        
        setChipHeight(height: (size == .medium ? 40 : 32))
    }
    
    func setChipHeight(height: CGFloat) {
        chipControlHeight.constant = height
        self.chipControl.layoutIfNeeded()
    }
    
}
