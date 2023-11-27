//
//  FormTextFieldVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 06/09/23.
//

import UIKit
import DesignComponents

class FormTextFieldVC: UIViewController {
    
    @IBOutlet weak var Default: FormTextFieldView!
    @IBOutlet weak var DefaultDisable: FormTextFieldView!
    @IBOutlet weak var withLeftImage: FormTextFieldView!
    @IBOutlet weak var withPercentage : FormTextFieldView!
    @IBOutlet weak var withIconPercentageDropdown: FormTextFieldView!
    @IBOutlet weak var withDropdown: FormTextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Default.currentState = .normal(title: "Normal", placeholder: "Default Varient")
        DefaultDisable.currentState = .normal(title: "Normal-Disable", placeholder: "Default with Disable")
        DefaultDisable.isEnabled = false
        withLeftImage.currentState = .withLeftIcon(title: "withLeftImage", placeholder: "withLeftImage",  icon: UIImage(named: "user_Image") ?? UIImage())
        withPercentage.currentState = .withPercentage(title: "withPercentage", placeholder: "withPercentage", percentage: "55")
        withIconPercentageDropdown.currentState = .withIconPercentageDropdown(title: "withIconPercentageDropdown", placeholder: "withIconPercentageDropdown", icon:  UIImage(named: "user_Image") ?? UIImage(), percentage: "85")
        withDropdown.currentState = .withDropdown(title: "withDropdown", placeholder: "withDropdown")
        
    }
}
