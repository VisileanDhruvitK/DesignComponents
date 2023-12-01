//
//  OTPInputVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 28/11/23.
//

import UIKit
import DesignComponents

class OTPInputVC: UIViewController {
    
    @IBOutlet weak var otpInputView: OTPInputView!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        submitButton.layer.borderWidth = 1
        submitButton.layer.cornerRadius = 24
        submitButton.layer.borderColor = UIColor.black.cgColor
        submitButton.clipsToBounds = true
        
        otpInputView.numberOfFields = .six
        otpInputView.set(title: "Input Title", optionalTitle: "(Optional)", hint: "This is a hint text to help user.")
        otpInputView.setOTP(otpString: "123654")
        // otpInputView.isEnabled = false
        otpInputView.delegate = self
    }
    
    @IBAction func clickedForHighlight(_ sender: UIButton) {
        self.view.endEditing(true)
        
        let finalOTP = otpInputView.getOTP()
        print("Final OTP : ",finalOTP)
        
        if finalOTP.count == otpInputView.numberOfFields.rawValue {
            
            if finalOTP == "123456" {
                otpInputView.isValidOTP = true
                otpInputView.hint = "This is a hint text to help user."
            } else {
                otpInputView.isValidOTP = false
                otpInputView.hint = "Please enter valid OTP"
            }
        } else {
            otpInputView.isValidOTP = false
        }
    }
    
}


// MARK: - OTPDelegate
extension OTPInputVC: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
        print("OTP valid - ", isValid)
    }
    
}
