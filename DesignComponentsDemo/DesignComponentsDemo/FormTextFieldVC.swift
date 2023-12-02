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
        
        Default.delegate = self
        withLeftImage.delegate = self
        withPercentage.delegate = self
        withIconPercentageDropdown.delegate = self
        
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
extension FormTextFieldVC: InputComponentDelegate {
    
    func shouldChangeCharactersIn(formTextFieldView: FormTextFieldView, _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, currentText: String, newString: String) {
        if formTextFieldView == Default {
            formTextFieldView.setValidationUI(validate: newString.count <= 5)
        } else if formTextFieldView == withPercentage {
            if newString.isEmpty {
                formTextFieldView.validationMessage = "pls Enter data"
            } else {
                formTextFieldView.validationMessage = ""
            }
            formTextFieldView.setValidationUI(validate: !newString.isEmpty)
        }
    }
    
    func didEndEditing(inputComponent: UITextField) {
        print("inputComponent - ", inputComponent.text ?? "")
    }
    
}
