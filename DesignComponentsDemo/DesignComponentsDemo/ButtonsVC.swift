//
//  ButtonsVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 06/09/23.
//

import UIKit
import DesignComponents

class ButtonsVC: UIViewController {
    
    @IBOutlet weak var submitButton: PrimaryButton!
    @IBOutlet weak var cancelButton: SecondaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func submitClicked(sender: UIButton) {
        submitButton.isEnabled.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.submitButton.isEnabled.toggle()
        }
    }
    
    @IBAction func cancelClicked(sender: UIButton) {
        cancelButton.isEnabled.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.cancelButton.isEnabled.toggle()
        }
    }
    
}
