//
//  ViewController.swift
//  DesignComponentsDemo
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import UIKit
import DesignComponents

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameView: FormTextFieldView!
    @IBOutlet weak var passwordView: FormTextFieldView!
    @IBOutlet weak var submitButton: PrimaryButton!
    @IBOutlet weak var cancelButton: SecondaryButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userNameView.set(titleText: "First Name", textFieldPlaceholder: "Ex. Bhargav")
        passwordView.set(titleText: "Last Name", textFieldPlaceholder: "Ex. Patel")
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

