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
    @IBOutlet weak var secondaryImageButton: VLButton!
    @IBOutlet weak var secondaryRightImageButton: RightImageButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        linkButton.textStyle = TextStyles.linkButton
        
        primaryButton.textStyle = .primaryButton
        primaryButton.apperance = .primaryButton
        
        secondaryButton.textStyle = .secondaryButton
        secondaryButton.apperance = .secondaryButton
        
        secondaryImageButton.textStyle = .secondaryImageButton
        secondaryImageButton.apperance = .secondaryImageButton
        secondaryImageButton.setImage(.arrowDown, for: .normal)
        
        secondaryRightImageButton.textStyle = .secondaryImageButton
        secondaryRightImageButton.apperance = .secondaryImageButton
        secondaryRightImageButton.setTitle("Test")
        secondaryRightImageButton.setImage(.arrowDown)
    }
    
    @IBAction func buttonClicked(sender: UIButton) {
        sender.isEnabled.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sender.isEnabled.toggle()
        }
    }
    
    @IBAction func rightImageButtonClicked(sender: RightImageButton) {
        sender.isEnabled.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            sender.isEnabled.toggle()
        }
    }
    
}
