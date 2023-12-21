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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(title: String, isSelected: Bool, size: ComponentSize = .medium, chipStyle: ChipStyle = .roundPA) {
        let option = ChipOption(title: title, isSelected: isSelected, chipType: .textOnly, chipStyle: chipStyle)
        chipControl.componentSize = size
        chipControl.setOption(option: option)
        chipControl.isUserInteractionEnabled = false
    }
    
    func configureCell(option: ChipOption, size: ComponentSize = .medium) {
        chipControl.setOption(option: option)
        chipControl.componentSize = size
        chipControl.isUserInteractionEnabled = false
    }
    
}
