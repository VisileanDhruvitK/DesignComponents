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
    @IBOutlet weak var normal: FormTextFieldView!
    @IBOutlet weak var normalDisable: FormTextFieldView!
    @IBOutlet weak var withLeftImage: FormTextFieldView!
    @IBOutlet weak var withPercentage : FormTextFieldView!
    @IBOutlet weak var withIconPercentageDropdown: FormTextFieldView!
    @IBOutlet weak var withDropdown: FormTextFieldView!
    @IBOutlet weak var withCost: FormTextFieldView!
    @IBOutlet weak var withCountry: FormTextFieldView!
    @IBOutlet weak var textField: VLTextField!
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        textField.placeholder = "VLTextField"
        
        normal.textField.delegate = self
        normalDisable.textField.delegate = self
        withLeftImage.textField.delegate = self
        withPercentage.textField.delegate = self
        withIconPercentageDropdown.textField.delegate = self
        withDropdown.textField.delegate = self
        withCost.textField.delegate = self
        withCountry.textField.delegate = self
        
        normal.setOption(option: FormTextFieldOption(title: "Normal", text: "New Task 123", placeholder: "Enter activity name", validationMessage: ""))
        normal.showInfoButton = true
        
        normalDisable.setOption(option: FormTextFieldOption(title: "Normal-Disable", placeholder: "Default with Disable", isEnabled: false))
        
        withLeftImage.setOption(option: FormTextFieldOption(title: "withLeftImage", placeholder: "withLeftImage", leftImage: UIImage(named: "user_Image"), fieldType: .withLeftAndRightIcon))
        
        withPercentage.setOption(option: FormTextFieldOption(title: "withPercentage", text: "New Constraint 123", placeholder: "Enter constraint name", percentage: "55", fieldType: .withPercentage))
        
        withIconPercentageDropdown.setOption(option: FormTextFieldOption(title: "withIconPercentageDropdown", placeholder: "withIconPercentageDropdown", percentage: "85", validationMessage: "Validation MSG...", leftImage: UIImage(named: "user_Image"), fieldType: .withIconPercentageDropdown))
        withIconPercentageDropdown.showMainButton = true
        
        withDropdown.setOption(option: FormTextFieldOption(title: "withDropdown", placeholder: "withDropdown", fieldType: .withRightIcon))
        withDropdown.showMainButton = true
        
        normal.delegate = self
        withLeftImage.delegate = self
        withIconPercentageDropdown.delegate = self
        withDropdown.delegate = self
        
        withLeftImage.setImageOption(option: ImageOption(color: .red, radiusType: .round), direction: .left)
        
        withCost.setOption(option: FormTextFieldOption(title: "Planned cost", placeholder: "Planned cost", leftText: "USD"))
        withCost.showLeftText = true
        
        withCountry.setOption(option: FormTextFieldOption(title: "Country", placeholder: "Choose country", leftText: "IND", leftImage: UIImage(named: "inputDropdown"), fieldType: .withLeftIcon))
        withCountry.showLeftText = true
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
        
        if textField == normal.textField {
            normal.showWarning = (newString.count > 5)
        } else if textField == withPercentage.textField {
            if newString.isEmpty {
                withPercentage.validationMessage = "pls Enter data"
            } else {
                withPercentage.validationMessage = ""
            }
            withPercentage.showWarning = newString.isEmpty
        }
        
        return true
    }
    
}

// MARK: - FormTextFieldDelegate
extension FormTextFieldVC: FormTextFieldDelegate {
    
    func infoButtonClicked(formField: FormTextFieldView) {
        if formField == normal {
            print("infoButtonClicked - normal")
        }
    }
    
    func leftButtonClicked(formField: FormTextFieldView) {
        if formField == withLeftImage {
            print("leftButtonClicked - withLeftImage")
        } else if formField == withIconPercentageDropdown {
            print("leftButtonClicked - withIconPercentageDropdown")
        }
    }
    
    func textFieldClicked(formField: FormTextFieldView) {
        if formField == withIconPercentageDropdown {
            print("textFieldClicked - withIconPercentageDropdown")
        } else if formField == withDropdown {
            print("textFieldClicked - withDropdown")
        }
    }
    
    func rightButtonClicked(formField: FormTextFieldView) {
        if formField == withLeftImage {
            print("rightButtonClicked - withLeftImage")
        } else if formField == withIconPercentageDropdown {
            print("rightButtonClicked - withIconPercentageDropdown")
        } else if formField == withDropdown {
            print("rightButtonClicked - withDropdown")
        }
    }
    
}
