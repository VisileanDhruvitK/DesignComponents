//
//  OTPInputView.swift
//  
//
//  Created by VisiLean Admin on 28/11/23.
//

import Foundation
import UIKit


public enum NumberOfFields: Int {
    case four = 4
    case six = 6
}


public class OTPInputView: UIView {
    
    // MARK: - Properties
    public weak var delegate: OTPDelegate?
    
    public var hint: String = "" {
        didSet {
            self.hintLabel.text = hint
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.hintLabel.isHidden = self.hint.isEmpty
            }
        }
    }
    
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
    
    public var numberOfFields: NumberOfFields = .four {
        didSet {
            otpStackView.numberOfFields = numberOfFields.rawValue
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .font14Regular
        label.textColor = .black_37
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        return label
    }()
    
    private lazy var optionalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .font14Regular
        label.textColor = .neutral_5
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, optionalLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 4
        return view
    }()
    
    private lazy var otpStackView = OTPStackView()
    
    private lazy var hintLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .font14Regular
        label.textColor = .neutral_5
        return label
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [hStackView, otpStackView, hintLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    deinit {
        removeNotificationCenterObserver()
    }
    
    func initialize() {
        addNotificationCenterObserver()
        setupSubViews()
    }
    
    func setupSubViews() {
        addSubview(vStackView)
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: topAnchor),
            vStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            vStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            hStackView.heightAnchor.constraint(equalToConstant: 20),
            otpStackView.heightAnchor.constraint(equalToConstant: 48),
            hintLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        otpStackView.delegate = self
        otpStackView.numberOfFields = numberOfFields.rawValue
        hintLabel.isHidden = hint.isEmpty
    }
    
    func addNotificationCenterObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeNotificationCenterObserver() {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    @objc func keyboardWillAppear(notification: Notification) {
        hintLabel.textColor = .primary_5
    }
    
    @objc func keyboardWillDisappear(notification: Notification) {
        hintLabel.textColor = .neutral_5
    }
    
    //update UI for OTP validation state
    private func updateValidationState() {
        otpStackView.isValidOTP = self.isValidOTP
        
        if isValidOTP {
            hintLabel.textColor = .neutral_5
        } else {
            hintLabel.textColor = .destructive_5
        }
    }
    
    //update UI state
    private func updateState() {
        otpStackView.isEnabled = self.isEnabled
    }
    
    //set title, optionalTitle & hint text
    public final func set(title: String, optionalTitle: String, hint: String) {
        titleLabel.text = title
        optionalLabel.text = optionalTitle
        hintLabel.text = hint
        
        optionalLabel.isHidden = optionalTitle.isEmpty
        hintLabel.isHidden = hint.isEmpty
    }
    
    //set the OTP text
    public final func setOTP(otpString: String) {
        otpStackView.setOTP(otpString: otpString)
    }
    
    //gives the OTP text
    public final func getOTP() -> String {
        return otpStackView.getOTP()
    }
    
    //set isWarningColor true for using it as a warning color
    public final func setAllFieldColor(isWarning: Bool = false, textColor: UIColor, borderColor: UIColor) {
        otpStackView.setAllFieldColor(isWarning: isWarning, textColor: textColor, borderColor: borderColor)
    }
    
}


// MARK: - OTPDelegate
extension OTPInputView: OTPDelegate {
    
    public func didChangeValidity(isValid: Bool) {
        self.delegate?.didChangeValidity(isValid: isValid)
    }
    
}
