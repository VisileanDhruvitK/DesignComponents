//
//  ButtonsVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 06/09/23.
//

import UIKit
import DesignComponents

class ButtonsVC: UIViewController {
    
    @IBOutlet weak var linkButton: VLButton!
    
    @IBOutlet weak var buttonS: VLButton!
    @IBOutlet weak var buttonM: VLButton!
    @IBOutlet weak var buttonL: VLButton!
    @IBOutlet weak var buttonXL: VLButton!
    @IBOutlet weak var buttonXXL: VLButton!
    @IBOutlet weak var buttonDynamic: VLButton!
    
    @IBOutlet weak var leftImageButton: ImageButton!
    @IBOutlet weak var rightImageButton: ImageButton!
    
    var isPrimaryButton: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        linkButton.buttonStyle = .link
        linkButton.componentSize = .medium
        
        buttonS.buttonStyle = .primary
        buttonM.buttonStyle = .primary
        buttonL.buttonStyle = .primary
        buttonXL.buttonStyle = .primary
        buttonXXL.buttonStyle = .primary
        
        buttonS.componentSize = .small
        buttonM.componentSize = .medium
        buttonL.componentSize = .large
        buttonXL.componentSize = .xl
        buttonXXL.componentSize = .xxl
        
        // buttonXXL.setImage(.highPriority, for: .normal)
        // buttonXXL.buttonImageStyle = .left
        
        buttonDynamic.buttonStyle = .dynamic
        buttonDynamic.componentSize = .xl
        buttonDynamic.titleColor = .destructive_5
        buttonDynamic.borderColor = .destructive_5
        buttonDynamic.borderWidth = 1
        buttonDynamic.setImage(.highPriority, for: .normal)
        buttonDynamic.setTitle("Right Image", for: .normal)
        // buttonDynamic.buttonImageStyle = .right
        
        leftImageButton.title = "Left Image"
        leftImageButton.image = .arrowDown
        leftImageButton.buttonStyle = .leftImage
        leftImageButton.componentSize = .medium
        
        rightImageButton.title = "Right Image"
        rightImageButton.image = .highPriority
        rightImageButton.buttonStyle = .rightImage
        rightImageButton.componentSize = .xl
        
        rightImageButton.bgColor = .white
        rightImageButton.titleColor = .destructive_5
        rightImageButton.borderColor = .destructive_5
        rightImageButton.borderWidth = 1
    }
    
    @IBAction func linkButtonClicked(sender: UIButton) {
        isPrimaryButton.toggle()
        
        if isPrimaryButton {
            buttonS.buttonStyle = .primary
            buttonM.buttonStyle = .primary
            buttonL.buttonStyle = .primary
            buttonXL.buttonStyle = .primary
            buttonXXL.buttonStyle = .primary
        } else {
            buttonS.buttonStyle = .secondary
            buttonM.buttonStyle = .secondary
            buttonL.buttonStyle = .secondary
            buttonXL.buttonStyle = .secondary
            buttonXXL.buttonStyle = .secondary
        }
    }
    
    @IBAction func buttonClicked(sender: UIButton) {
        sender.isEnabled.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sender.isEnabled.toggle()
        }
    }
    
    @IBAction func imageButtonClicked(sender: ImageButton) {
        sender.isEnabled.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sender.isEnabled.toggle()
        }
    }
    
}
