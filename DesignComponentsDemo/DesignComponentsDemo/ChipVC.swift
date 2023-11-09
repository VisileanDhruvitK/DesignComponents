//
//  ChipVC.swift
//  DesignComponentsDemo
//
//  Created by Meet on 11/09/23.
//

import UIKit
import DesignComponents

class ChipVC: UIViewController {
    
    @IBOutlet weak var radioState: RadioButton!
    @IBOutlet weak var radioSizes: RadioButtonView!
    
    @IBOutlet weak var chipText: ChipControl!
    @IBOutlet weak var chipTextButton: ChipControl!
    @IBOutlet weak var chipImageText: ChipControl!
    @IBOutlet weak var chipImageTextButton: ChipControl!
    
    @IBOutlet weak var chipHeightConst: NSLayoutConstraint!
    
    var sizeOptions = [RadioOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and configure the chip control
        chipText.chipType = .with(text: "text only", isButtonHidden: true, chipStyle: .roundSU)
        chipTextButton.chipType = .with(text: "text & btn", isButtonHidden: false, chipStyle: .squreSU)
        chipImageText.chipType = .with(image: UIImage(named: "user_Image"), text: "text image", isButtonHidden: true, chipStyle: .roundPA)
        chipImageTextButton.chipType = .with(image: UIImage(named: "user_Image"), text: "text image btn", isButtonHidden: false, chipStyle: .squrePA)
        
        chipImageText.isSelected = true
        
        chipText.componentSize = .small
        chipTextButton.componentSize = .small
        chipImageText.componentSize = .small
        chipImageTextButton.componentSize = .small
        chipHeightConst.constant = 32
        self.view.layoutIfNeeded()
        
        radioState.setOption(option: RadioOption(title: "Enable", isOn: true))
        radioState.addTarget(self, action: #selector(radioStateSelected(_:)), for: .valueChanged)
        
        fetchSizes()
    }
    
    func fetchSizes() {
        sizeOptions.removeAll()
        
        let option1 = RadioOption(title: "Small", description: "", isOn: true)
        let option2 = RadioOption(title: "Medium", description: "")
        
        sizeOptions.append(contentsOf: [option1, option2])
        
        radioSizes.set(sizeOptions)
        radioSizes.tag = 1
        radioSizes.delegate = self
    }
    
    @objc func radioStateSelected(_ sender: RadioButton) {
        sender.isOn.toggle()
        chipText.isEnabled = sender.isOn
        chipTextButton.isEnabled = sender.isOn
        chipImageText.isEnabled = sender.isOn
        chipImageTextButton.isEnabled = sender.isOn
    }
    
}

extension ChipVC: RadioSelectionDelegate {
    
    func didSelectRadioButton(tag: Int, indexes: Set<Int>) {
        let option = sizeOptions[indexes.first ?? 0]
        if option.title == "Small" {
            chipHeightConst.constant = 32
            self.view.layoutIfNeeded()
            
            chipText.componentSize = .small
            chipTextButton.componentSize = .small
            chipImageText.componentSize = .small
            chipImageTextButton.componentSize = .small
        } else {
            chipHeightConst.constant = 40
            self.view.layoutIfNeeded()
            
            chipText.componentSize = .medium
            chipTextButton.componentSize = .medium
            chipImageText.componentSize = .medium
            chipImageTextButton.componentSize = .medium
        }
    }
    
}
