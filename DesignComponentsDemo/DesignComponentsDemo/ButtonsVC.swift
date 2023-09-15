//
//  ButtonsVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 06/09/23.
//

import UIKit
import DesignComponents

class ButtonsVC: UIViewController {
    
    @IBOutlet weak var primaryButton: VLButton!
    @IBOutlet weak var secondaryButton: VLButton!
    @IBOutlet weak var linkButton: VLButton!
    @IBOutlet weak var leftImageButton: ImageButton!
    @IBOutlet weak var rightImageButton: ImageButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        primaryButton.buttonStyle = .primary
        secondaryButton.buttonStyle = .secondary
        linkButton.buttonStyle = .link
        
        leftImageButton.title = "Left Image"
        leftImageButton.image = .arrowDown
        leftImageButton.buttonStyle = .leftImage
        leftImageButton.componentSize = .medium
        
        rightImageButton.title = "Right Image"
        rightImageButton.image = .arrowDown
        rightImageButton.buttonStyle = .rightImage
        leftImageButton.componentSize = .extraLarge
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
