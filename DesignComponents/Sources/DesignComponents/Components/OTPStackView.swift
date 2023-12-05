//
//  OTPStackView.swift
//  
//
//  Created by VisiLean Admin on 28/11/23.
//

import Foundation
import UIKit


protocol OTPStackViewDelegate: AnyObject {
    //always triggers when the OTP field is valid
    func didChangeValidity(isValid: Bool)
}


public class OTPStackView: UIStackView {
    
    public var isValidOTP: Bool = true {
        didSet {
            updateValidationState()
        }
    }
    
    public var isEnabled: Bool = true {
        didSet {
            updateState()
        }
    }
    
    //Customise the OTPField here
    public var numberOfFields: Int = 6 {
        didSet {
            addOTPFields()
        }
    }
    
    private var textFieldsCollection: [OTPTextField] = []
    weak var delegate: OTPStackViewDelegate?
    var showsWarning = false
    
    //Colors
    var inactiveTextColor: UIColor = .neutral_6
    var activeTextColor: UIColor = .primary_7
    var warningTextColor: UIColor = .destructive_7
    
    var inactiveFieldBorderColor: UIColor = .neutral_2
    var activeFieldBorderColor: UIColor = .primary_5
    var warningFieldBorderColor: UIColor = .destructive_5
    
    var enabledFieldBackgroundColor: UIColor = .clear
    var disableFieldBackgroundColor: UIColor = .neutral_0_5
    
    var remainingStrStack: [String] = []
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupStackView()
        addOTPFields()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStackView()
        addOTPFields()
    }
    
    //Customisation and setting stackView
    private final func setupStackView() {
        self.axis = .horizontal
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .center
        self.distribution = .fillEqually
        self.spacing = 8
    }
    
    //Adding each OTPfield to stack view
    private final func addOTPFields() {
        self.removeAllArrangedSubviews()
        textFieldsCollection.removeAll()
        
        for index in 0..<numberOfFields {
            let field = OTPTextField()
            setupTextField(field)
            textFieldsCollection.append(field)
            
            //Adding a marker to previous field
            index != 0 ? (field.previousTextField = textFieldsCollection[index-1]) : (field.previousTextField = nil)
            
            //Adding a marker to next field for the field at index-1
            index != 0 ? (textFieldsCollection[index-1].nextTextField = field) : ()
        }
        textFieldsCollection[0].becomeFirstResponder()
    }
    
    //Customisation and setting OTPTextFields
    private final func setupTextField(_ textField: OTPTextField) {
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = false
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .yes
        textField.textContentType = .oneTimeCode
        textField.backgroundColor = enabledFieldBackgroundColor
        
        textField.font = .font24Regular
        textField.textColor = inactiveTextColor
        textField.layer.borderColor = inactiveFieldBorderColor.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 10
        
        self.addArrangedSubview(textField)
        textField.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    //update UI state
    private func updateState() {
        for textField in textFieldsCollection {
            textField.isEnabled = isEnabled
            
            if isEnabled {
                textField.backgroundColor = enabledFieldBackgroundColor
            } else {
                textField.backgroundColor = disableFieldBackgroundColor
            }
        }
    }
    
    //update UI for OTP validation state
    private func updateValidationState() {
        if isEnabled == false {
            return
        }
        
        for textField in textFieldsCollection {
            if isValidOTP {
                textField.textColor = inactiveTextColor
                textField.layer.borderColor = inactiveFieldBorderColor.cgColor
            } else {
                textField.textColor = warningTextColor
                textField.layer.borderColor = warningFieldBorderColor.cgColor
            }
        }
    }
    
    //checks if all the OTPfields are filled
    private final func checkForValidity() {
        for fields in textFieldsCollection {
            if (fields.text == "") {
                delegate?.didChangeValidity(isValid: false)
                return
            }
        }
        delegate?.didChangeValidity(isValid: true)
    }
    
    //set the OTP text
    public final func setOTP(otpString: String) {
        var otpArray: [String] = otpString.map({ String($0) })
        otpArray = otpArray.filter({ $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false })
        
        var lastIndex: Int?
        
        if otpArray.count <= textFieldsCollection.count {
            for index in 0 ..< otpArray.count {
                textFieldsCollection[index].text = otpArray[index]
                lastIndex = index
            }
        } else if textFieldsCollection.count <= otpArray.count {
            for index in 0 ..< textFieldsCollection.count {
                textFieldsCollection[index].text = otpArray[index]
                lastIndex = index
            }
        }
        
        if let lastIndex = lastIndex {
            if (lastIndex + 1) < textFieldsCollection.count {
                DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
                    self?.textFieldsCollection[lastIndex + 1].becomeFirstResponder()
                }
            } else if (lastIndex + 1) >= textFieldsCollection.count {
                DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
                    self?.endEditing(true)
                }
            }
        }
    }
    
    //gives the OTP text
    public final func getOTP() -> String {
        var OTP = ""
        for textField in textFieldsCollection{
            OTP += textField.text ?? ""
        }
        return OTP
    }
    
    //set isWarningColor true for using it as a warning color
    public final func setAllFieldColor(isWarning: Bool = false, textColor: UIColor, borderColor: UIColor) {
        for textField in textFieldsCollection {
            textField.textColor = textColor
            textField.layer.borderColor = borderColor.cgColor
        }
        showsWarning = isWarning
    }
    
    //autofill textfield starting from first
    private final func autoFillTextField(with string: String) {
        remainingStrStack = string.reversed().compactMap{String($0)}
        for textField in textFieldsCollection {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
            } else {
                break
            }
        }
        checkForValidity()
        remainingStrStack = []
    }
    
}


// MARK: - TextField Handling
extension OTPStackView: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if showsWarning {
            setAllFieldColor(textColor: warningTextColor, borderColor: warningFieldBorderColor)
            showsWarning = false
        } else {
            setAllFieldColor(textColor: inactiveTextColor, borderColor: inactiveFieldBorderColor)
        }
        
        textField.textColor = activeTextColor
        textField.layer.borderColor = activeFieldBorderColor.cgColor
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        checkForValidity()
        
        textField.textColor = inactiveTextColor
        textField.layer.borderColor = inactiveFieldBorderColor.cgColor
    }
    
    //switches between OTPTextfields
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange, replacementString string: String) -> Bool {
        
        guard let textField = textField as? OTPTextField else { return true }
        
        let newString = ((textField.text as? NSString) ?? NSString()).replacingCharacters(in: range, with: string) as NSString
        if newString.rangeOfCharacter(from: NSCharacterSet.whitespacesAndNewlines).length > 0 {
            return false
        }
        
        if string.count > 1 {
            textField.resignFirstResponder()
            autoFillTextField(with: string)
            return false
        } else {
            if (range.length == 0) {
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                } else {
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }
    
}
