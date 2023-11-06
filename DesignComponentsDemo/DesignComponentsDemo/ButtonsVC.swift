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
        
        leftImageButton.title = "Left Image"
        leftImageButton.image = .arrowDown
        leftImageButton.buttonStyle = .leftImage
        leftImageButton.componentSize = .medium
        
        rightImageButton.title = "Right Image"
        rightImageButton.image = .arrowDown
        rightImageButton.buttonStyle = .rightImage
        leftImageButton.componentSize = .xl
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
    
    @IBAction func rightImageButtonClicked(sender: ImageButton) {
        sender.isEnabled.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sender.isEnabled.toggle()
        }
    }
    
}
