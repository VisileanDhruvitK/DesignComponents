//
//  FormTextFieldVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 06/09/23.
//

import UIKit
import DesignComponents

class FormTextFieldVC: UIViewController {
    
    @IBOutlet weak var userNameView: FormTextFieldView!
    @IBOutlet weak var passwordView: FormTextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userNameView.set(titleText: "First Name", textFieldPlaceholder: "Ex. Bhargav")
        passwordView.set(titleText: "Last Name", textFieldPlaceholder: "Ex. Patel")
    }
    
}
