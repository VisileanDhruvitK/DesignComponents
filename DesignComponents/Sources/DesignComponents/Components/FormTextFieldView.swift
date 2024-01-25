//
//  FormTextFieldView.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import UIKit

public struct FormTextFieldOption {
    public var title: String = ""
    public var text: String = ""
    public var placeholder: String = ""
    public var leftText: String = ""
    public var percentage: String = ""
    public var validationMessage = ""
    public var leftImage: UIImage? = nil
    public var rightImage: UIImage? = nil
    public var isEnabled: Bool = false
    public var fieldType: FormTextFieldType = .normal
    
    public init(title: String = "", text: String = "", placeholder: String = "", leftText: String = "", percentage: String = "", validationMessage: String = "", leftImage: UIImage? = nil, rightImage: UIImage? = nil, isEnabled: Bool = true, fieldType: FormTextFieldType = .normal) {
        self.title = title
        self.text = text
        self.placeholder = placeholder
        self.leftText = leftText
        self.percentage = percentage
        self.validationMessage = validationMessage
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.isEnabled = isEnabled
        self.fieldType = fieldType
    }
    
}

public enum FormTextFieldType {
    case normal
    case withLeftIcon
    case withLeftAndRightIcon
    case withPercentage
    case withIconPercentageDropdown
    case withRightIcon
}

@objc public protocol FormTextFieldDelegate: AnyObject {
    @objc optional func leftButtonClicked(formField: FormTextFieldView)
    @objc optional func rightButtonClicked(formField: FormTextFieldView)
    @objc optional func textFieldClicked(formField: FormTextFieldView)
}

public class FormTextFieldView: UIView {
    
    // MARK: - Properties
    public var showWarning: Bool = false {
        didSet {
            setValidationUI()
        }
    }
    
    public var delegate: FormTextFieldDelegate?
    
    public var fieldType: FormTextFieldType = .normal {
        didSet {
            setUI()
        }
    }
    
    public var isRequired: Bool = false {
        didSet {
            titleLabel.attributedText = titleLabel.text?.addRedStar()
        }
    }
    
    public var showMainButton: Bool = false {
        didSet {
            mainButton.isHidden = !showMainButton
            textField.isUserInteractionEnabled = !showMainButton
        }
    }
    
    public var title: String = "" {
        didSet {
            if isRequired {
                titleLabel.attributedText = titleLabel.text?.addRedStar()
            } else {
                titleLabel.text = title
            }
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
    
    public var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    public var percentage: String = "" {
        didSet {
            percentagelabel.text = percentage + "%"
        }
    }
    
    public var showLeftText: Bool = false {
        didSet {
            setUI()
        }
    }
    
    public var leftText: String = "" {
        didSet {
            leftLabel.text = leftText
        }
    }
    
    public var leftImage: UIImage? = nil {
        didSet {
            leftButton.setImage(leftImage, for: .normal)
        }
    }
    
    public var rightImage: UIImage? = nil {
        didSet {
            rightButton.setImage(rightImage, for: .normal)
        }
    }
    
    public var validationMessage = "" {
        didSet {
            descriptionLabel.text = validationMessage
            descriptionLabel.isHidden = validationMessage.isEmpty
        }
    }
    
    public var isEnabled: Bool = true {
        didSet {
            updateUIState()
        }
    }
    
    // Title Label
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .font14Medium
        label.textColor = .primary_7
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
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
    
    public lazy var textField: UITextField = {
        let txtField = UITextField()
        txtField.textColor = .primary_7
        txtField.tintColor = .primary_7
        txtField.font = .font14Regular
        txtField.autocorrectionType = .no
        txtField.autocapitalizationType = .none
        txtField.clipsToBounds = true
        return txtField
    }()
    
    // Percentage label and Image
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
    
    // Left Label
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalToConstant: 30).isActive = true
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .font14Regular
        label.textColor = .neutral_5
        return label
    }()
    
    // Left Button
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.isHidden = true
        button.clipsToBounds = true
        return button
    }()
    
    // Left Separator
    private lazy var leftSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 1.5).isActive = true
        view.backgroundColor = .neutral_1_5
        view.clipsToBounds = true
        return view
    }()
    
    // Right Button
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.setImage(.inputDropdown, for: .normal)
        button.isHidden = true
        button.clipsToBounds = true
        return button
    }()
    
    // TextField StackView with Image, TextField, Percentage View & Button
    private lazy var stackViewTextField: UIStackView = {
        let view = UIStackView(arrangedSubviews: [leftLabel, leftButton, leftSeparator, textField, stackViewWithPercentage, rightButton])
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
        view.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return view
    }()
    
    // Description Label
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
    
    // Main Button
    private lazy var mainButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    deinit {
        removeTargets()
    }
    
    func initialize() {
        self.backgroundColor = .clear
        setupSubViews()
        addTargets()
    }
    
    func setupSubViews() {
        addSubview(stackView)
        addSubview(mainButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            mainButton.topAnchor.constraint(equalTo: txtView.topAnchor, constant: 0),
            mainButton.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 0),
            mainButton.bottomAnchor.constraint(equalTo: txtView.bottomAnchor, constant: 0),
            mainButton.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 0),
            
            stackViewTextField.topAnchor.constraint(equalTo: txtView.topAnchor, constant: 14),
            stackViewTextField.leadingAnchor.constraint(equalTo: txtView.leadingAnchor, constant: 14),
            stackViewTextField.bottomAnchor.constraint(equalTo: txtView.bottomAnchor, constant: -14),
            stackViewTextField.trailingAnchor.constraint(equalTo: txtView.trailingAnchor, constant: -14)
        ])
    }
    
    public func setOption(option: FormTextFieldOption) {
        title = option.title
        text = option.text
        placeholder = option.placeholder
        leftText = option.leftText
        percentage = option.percentage
        validationMessage = option.validationMessage
        leftImage = option.leftImage
        rightImage = option.rightImage
        
        isEnabled = option.isEnabled
        isUserInteractionEnabled = option.isEnabled
        
        fieldType = option.fieldType
    }
    
    func setUI() {
        leftLabel.isHidden = !showLeftText
        leftSeparator.isHidden = !showLeftText
        leftButton.isHidden = true
        rightButton.isHidden = true
        stackViewWithPercentage.isHidden = true
        
        stackView.spacing = (title.isEmpty && validationMessage.isEmpty) ? 0 : 8
        
        switch fieldType {
        case .normal:
            break
        case .withLeftIcon:
            leftButton.isHidden = false
        case .withLeftAndRightIcon:
            leftButton.isHidden = false
            rightButton.isHidden = false
            if rightImage == nil {
                rightImage = .inputDropdown
            }
        case .withPercentage:
            stackViewWithPercentage.isHidden = false
        case .withIconPercentageDropdown:
            leftButton.isHidden = false
            stackViewWithPercentage.isHidden = false
            rightButton.isHidden = false
            if rightImage == nil {
                rightImage = .inputDropdown
            }
        case .withRightIcon:
            rightButton.isHidden = false
            if rightImage == nil {
                rightImage = .inputDropdown
            }
        }
    }
    
    public func setImageOption(option: ImageOption, direction: Direction) {
        if direction == .left {
            leftImage = option.image
            leftButton.backgroundColor = option.color
            leftButton.layer.borderColor = option.borderColor?.cgColor
            leftButton.layer.borderWidth = option.borderWidth
            
            if option.radiusType == .round {
                leftButton.layer.cornerRadius = 10
            } else if option.radiusType == .roundedRect {
                leftButton.layer.cornerRadius = 5
            }
        } else {
            rightImage = option.image
            rightButton.backgroundColor = option.color
            rightButton.layer.borderColor = option.borderColor?.cgColor
            rightButton.layer.borderWidth = option.borderWidth
            
            if option.radiusType == .round {
                rightButton.layer.cornerRadius = 10
            } else if option.radiusType == .roundedRect {
                rightButton.layer.cornerRadius = 5
            }
        }
    }
    
    func addTargets() {
        textField.addTarget(self, action: #selector(textFieldBeginEditingNotification(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEndEditingNotification(_:)), for: .editingDidEnd)
        
        leftButton.addTarget(self, action: #selector(leftButtonClicked(_:)), for: .touchUpInside)
        mainButton.addTarget(self, action: #selector(mainButtonClicked(_:)), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonClicked(_:)), for: .touchUpInside)
    }
    
    func removeTargets() {
        textField.removeTarget(self, action: #selector(textFieldBeginEditingNotification(_:)), for: .editingDidBegin)
        textField.removeTarget(self, action: #selector(textFieldEndEditingNotification(_:)), for: .editingDidEnd)
        
        leftButton.removeTarget(self, action: #selector(leftButtonClicked(_:)), for: .touchUpInside)
        mainButton.removeTarget(self, action: #selector(mainButtonClicked(_:)), for: .touchUpInside)
        rightButton.removeTarget(self, action: #selector(rightButtonClicked(_:)), for: .touchUpInside)
    }
    
    @objc func textFieldBeginEditingNotification(_ textField: UITextField) {
        // Change the border color when the textField gains focus
        if showWarning {
            return
        }
        
        textField.textColor = .primary_7
        descriptionLabel.textColor = .primary_5
        leftSeparator.backgroundColor = .primary_5
        txtView.layer.borderColor = UIColor.primary_5.cgColor
    }
    
    @objc func textFieldEndEditingNotification(_ textField: UITextField) {
        // Change the border color back when the textField loses focus
        if showWarning {
            return
        }
        
        textField.textColor = .primary_7
        descriptionLabel.textColor = .neutral_5
        leftSeparator.backgroundColor = .neutral_1_5
        txtView.layer.borderColor = UIColor.neutral_1_5.cgColor
    }
    
    @objc func leftButtonClicked(_ sender: UIButton) {
        delegate?.leftButtonClicked?(formField: self)
    }
    
    @objc func mainButtonClicked(_ sender: UIButton) {
        delegate?.textFieldClicked?(formField: self)
    }
    
    @objc func rightButtonClicked(_ sender: UIButton) {
        delegate?.rightButtonClicked?(formField: self)
    }
    
    // Set styles for enabled/disabled state
    private func updateUIState() {
        isUserInteractionEnabled = isEnabled
        textField.isEnabled = isEnabled
        leftButton.isUserInteractionEnabled = isEnabled
        mainButton.isUserInteractionEnabled = isEnabled
        rightButton.isUserInteractionEnabled = isEnabled
        
        if isEnabled {
            textField.textColor = .primary_7
            descriptionLabel.textColor = .neutral_5
            txtView.layer.borderColor = UIColor.neutral_1_5.cgColor
            txtView.backgroundColor = UIColor.clear
        } else {
            txtView.backgroundColor = UIColor.neutral_0_5
        }
    }
    
    private func setValidationUI() {
        descriptionLabel.isHidden = validationMessage.isEmpty == true
        
        if !showWarning {
            if textField.isFirstResponder {
                txtView.layer.borderColor = UIColor.primary_5.cgColor
                leftSeparator.backgroundColor = .primary_5
                descriptionLabel.textColor = .primary_5
                textField.textColor = .primary_7
            } else {
                txtView.layer.borderColor = UIColor.neutral_1_5.cgColor
                leftSeparator.backgroundColor = .neutral_1_5
                descriptionLabel.textColor = .neutral_5
                textField.textColor = .primary_7
            }
        } else {
            txtView.layer.borderColor = UIColor.destructive_5.cgColor
            leftSeparator.backgroundColor = .destructive_5
            descriptionLabel.textColor = .destructive_5
            textField.textColor = .destructive_5
        }
    }
    
}
