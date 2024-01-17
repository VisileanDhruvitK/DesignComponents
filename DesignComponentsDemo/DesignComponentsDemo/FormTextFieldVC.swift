//
//  FormTextFieldVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 06/09/23.
//

import UIKit
import DesignComponents

class FormTextFieldVC: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var Default: FormTextFieldView!
    @IBOutlet weak var DefaultDisable: FormTextFieldView!
    @IBOutlet weak var withLeftImage: FormTextFieldView!
    @IBOutlet weak var withPercentage : FormTextFieldView!
    @IBOutlet weak var withIconPercentageDropdown: FormTextFieldView!
    @IBOutlet weak var withDropdown: FormTextFieldView!
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Default.textField.delegate = self
        withLeftImage.textField.delegate = self
        withPercentage.textField.delegate = self
        withIconPercentageDropdown.textField.delegate = self
        
        Default.currentState = .normal(title: "Normal", text: "New Task 123", placeholder: "Enter activity name")
        Default.validationMessage = "Validation MSG ..."
        
        DefaultDisable.currentState = .normal(title: "Normal-Disable", text: "", placeholder: "Default with Disable")
        DefaultDisable.isEnabled = false
        
        withLeftImage.currentState = .withLeftIcon(title: "withLeftImage", text: "", placeholder: "withLeftImage",  icon: UIImage(named: "user_Image") ?? UIImage())
        
        withPercentage.currentState = .withPercentage(title: "withPercentage", text: "New Constraint 123", placeholder: "Enter constraint name", percentage: "55")
        
        withIconPercentageDropdown.currentState = .withIconPercentageDropdown(title: "withIconPercentageDropdown", text: "", placeholder: "withIconPercentageDropdown", icon:  UIImage(named: "user_Image") ?? UIImage(), percentage: "85")
        withIconPercentageDropdown.validationMessage = "Validation MSG..."
        
        withDropdown.currentState = .withDropdown(title: "withDropdown", text: "", placeholder: "withDropdown")
    }
    
}


//MARK: - InputComponentDelegate
extension FormTextFieldVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newString  = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if textField == Default.textField {
            Default.setValidationUI(validate: newString.count <= 5)
        } else if textField == withPercentage.textField {
            if newString.isEmpty {
                withPercentage.validationMessage = "pls Enter data"
            } else {
                withPercentage.validationMessage = ""
            }
            withPercentage.setValidationUI(validate: !newString.isEmpty)
        }
        
        return true
    }
    
}
