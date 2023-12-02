//
//  FormTextFieldView.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import UIKit

@objc public protocol InputComponentDelegate: AnyObject {
    func didEndEditing(inputComponent: UITextField)
    @objc optional  func shouldChangeCharactersIn(formTextFieldView: FormTextFieldView, _ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, currentText: String, newString: String)
}

public enum FormTextFieldType {
    case normal
    case withLeftIcon
    case withPercentage
    case withIconPercentageDropdown
    case withDropdown
}

public enum FormTextFieldConfiguration {
    case normal(title: String, text: String, placeholder: String)
    case withLeftIcon(title: String, text: String, placeholder: String, icon: UIImage)
    case withPercentage(title: String, text: String, placeholder: String, percentage: String)
    case withIconPercentageDropdown(title: String, text: String, placeholder: String, icon: UIImage, percentage: String)
    case withDropdown(title: String, text: String, placeholder: String)
    
    var fieldType: FormTextFieldType {
        switch self {
        case .normal(_, _ ,_):
            return .normal
        case .withLeftIcon(_, _, _, _):
            return .withLeftIcon
        case .withPercentage(_, _, _, _):
            return .withPercentage
        case .withIconPercentageDropdown(_, _, _, _, _):
            return .withIconPercentageDropdown
        case .withDropdown(_, _, _):
            return .withDropdown
        }
    }
}

public class FormTextFieldView: UIView {
    
    // MARK: - Properties
    private var showWarning: Bool = false
    
    public var fieldType: FormTextFieldType = .normal
    public weak var delegate: InputComponentDelegate?
    
    public var currentState: FormTextFieldConfiguration = .normal(title: "", text: "", placeholder: "") {
        didSet {
            updateViewState()
        }
    }
    
    public var text: String {
        get {
            return textField.text ?? ""
        }
        set {
            textField.text = newValue
        }
    }
    
    public var placeholder: String {
        get {
            return textField.placeholder ?? ""
        }
        set {
            textField.placeholder = newValue
        }
    }
    
    public var validationMessage = "" {
        didSet {
            descriptionLabel.text = validationMessage
            descriptionLabel.isHidden = validationMessage.isEmpty
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
    
    private lazy var textField: UITextField = {
        let txtField = UITextField()
        txtField.textColor = .primary_7
        txtField.font = .font14Regular
        txtField.autocorrectionType = .no
        txtField.autocapitalizationType = .none
        txtField.clipsToBounds = true
        txtField.delegate = self
        return txtField
    }()
    
    //percentage label and Image
    private lazy var percentagelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .destructive_5
        return label
    }()
    
    private lazy var percentageImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        imgView.contentMode = .scaleAspectFit
        imgView.image = .percentageDown
        return imgView
    }()
    
    private lazy var stackViewWithPercentage: UIStackView = {
        let view = UIStackView(arrangedSubviews: [percentagelabel, percentageImageView])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 0
        view.isHidden = true
        return view
    }()
    
    //Left Image
    private lazy var leftImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        imgView.contentMode = .scaleAspectFit
        imgView.isHidden = true
        return imgView
    }()
    
    //Right Button
    private lazy var buttonDropDown: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        button.setImage(.inputDropdown, for: .normal)
        button.isHidden = true
        return button
    }()
    
    // TextField StackView with Image, TextField, Percentage View & Button
    private lazy var stackViewTextField: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftImageView, textField, stackViewWithPercentage, buttonDropDown])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    // Container View for TextField StackView
    private lazy var txtView: UIView = {
        let view = UIView()
        view.addSubview(stackViewTextField)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.neutral_1_5.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    //SubText
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .neutral_5
        label.isHidden = true
        return label
    }()
    
    // Main StackView with all UI elements
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [hStackView, txtView, descriptionLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func updateViewState() {
        fieldType = currentState.fieldType
        
        switch currentState {
        case .normal(let title, let text, let textFieldPlaceholder):
            setViewState(title: title, text: text, placeholder: textFieldPlaceholder, leftIcon: nil, showDropdown: false, showPercentage: false)
            
        case .withLeftIcon(let title, let text, let textFieldPlaceholder, let icon):
            setViewState(title: title, text: text, placeholder: textFieldPlaceholder, leftIcon: icon, showDropdown: false, showPercentage: false)
            
        case .withPercentage(let title, let text, let textFieldPlaceholder, let percent):
            setViewState(title: title, text: text, placeholder: textFieldPlaceholder, leftIcon: nil, showDropdown: false, showPercentage: true)
            percentagelabel.text = percent + "%"
            
        case .withIconPercentageDropdown(let title, let text, let textFieldPlaceholder, let icon, let percent):
            setViewState(title: title, text: text, placeholder: textFieldPlaceholder, leftIcon: icon, showDropdown: true, showPercentage: true)
            percentagelabel.text = percent + "%"
            
        case .withDropdown(let title, let text, let textFieldPlaceholder):
            setViewState(title: title, text: text, placeholder: textFieldPlaceholder, leftIcon: nil, showDropdown: true, showPercentage: false)
        }
    }
    
    private func setViewState(title: String, text: String, placeholder: String, leftIcon: UIImage?, showDropdown: Bool, showPercentage: Bool) {
        titleLabel.text = title
        textField.text = text
        textField.placeholder = placeholder
        leftImageView.isHidden = leftIcon == nil
        leftImageView.image = leftIcon
        buttonDropDown.isHidden = !showDropdown
        stackViewWithPercentage.isHidden = !showPercentage
    }
    
    public var isEnabled: Bool {
        get {
            return textField.isEnabled
        }
        set {
            textField.isEnabled = newValue
            applyEnabledStyle()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    func initialize() {
        setupSubViews()
    }
    
    func setupSubViews() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            txtView.heightAnchor.constraint(equalToConstant: 48),
            
            stackViewTextField.topAnchor.constraint(equalTo: txtView.topAnchor, constant: 14),
            stackViewTextField.leadingAnchor.constraint(equalTo: txtView.leadingAnchor, constant: 14),
            stackViewTextField.bottomAnchor.constraint(equalTo: txtView.bottomAnchor, constant: -14),
            stackViewTextField.trailingAnchor.constraint(equalTo: txtView.trailingAnchor, constant: -14)
        ])
    }
    
    //MARK: Enable/Disable state
    func applyEnabledStyle() {
        if isEnabled {
            // Set styles for enabled state
            textField.textColor = .formItemText
            descriptionLabel.textColor = .neutral_5
            txtView.layer.borderColor = UIColor.neutral_1_5.cgColor
            txtView.backgroundColor = UIColor.clear
        } else {
            // Set styles for disabled state
            txtView.backgroundColor = UIColor.neutral_0_5
        }
    }
    
    public func setValidationUI(validate: Bool) {
        showWarning = !validate
        if validate {
            txtView.layer.borderColor = UIColor.primary_5.cgColor
            descriptionLabel.isHidden = descriptionLabel.text?.isEmpty == true
            descriptionLabel.textColor = .primary_7
            textField.textColor = .primary_7
        } else {
            txtView.layer.borderColor = UIColor.destructive_5.cgColor
            descriptionLabel.textColor = .destructive_5
            textField.textColor = .destructive_5
            showValidationMessage(message: validationMessage)
        }
    }
    
    public func showValidationMessage(message: String) {
        if !message.isEmpty {
            descriptionLabel.isHidden = false
            descriptionLabel.text = message
        }
    }
}

//MARK: - UITextFieldDelegate
extension FormTextFieldView : UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        // Change the border color when the textField gains focus
        if showWarning {
            return
        }
        textField.layer.masksToBounds = true
        textField.textColor = .primary_7
        descriptionLabel.textColor = .primary_5
        txtView.layer.borderColor = UIColor.primary_5.cgColor
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        // Change the border color back when the textField loses focus
        if showWarning {
            return
        }
        
        textField.layer.masksToBounds = true
        textField.textColor = .formItemText
        descriptionLabel.textColor = .neutral_5
        txtView.layer.borderColor = UIColor.neutral_1_5.cgColor
        delegate?.didEndEditing(inputComponent: textField)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
        
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        let newString  = (currentText as NSString).replacingCharacters(in: range, with: string)
        delegate?.shouldChangeCharactersIn?(formTextFieldView: self, textField, shouldChangeCharactersIn: range, replacementString: string, currentText: currentText, newString: newString)
        return true
    }
    
}
