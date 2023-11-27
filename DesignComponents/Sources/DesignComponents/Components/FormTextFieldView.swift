//
//  FormTextFieldView.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import UIKit


public enum FormTextFieldViewState {
    case normal(title: String, placeholder: String)
    case withLeftIcon(title: String, placeholder: String, icon: UIImage)
    case withPercentage(title: String, placeholder: String, percentage: String)
    case withIconPercentageDropdown(title: String, placeholder: String, icon: UIImage, percentage: String)
    case withDropdown(title: String, placeholder: String)
    
}

public class FormTextFieldView: UIView {
    
    // MARK: - Properties
    private lazy var titleLabel = UILabel()
    private lazy var textField = UITextField()

    public var currentState: FormTextFieldViewState = .normal(title: "", placeholder: "") {
           didSet {
               updateViewState()
           }
       }
       
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 8
        return view
    }()
    
    private lazy var stackViewTextField: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    private lazy var txtView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1.5
        view.layer.cornerRadius = 10
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
        
    //With Percentage
    private lazy var stackViewWithPercentage: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 0
        view.isHidden = true
        return view
    }()
    
    private lazy var percentagelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.textColor = .red
        return label
    }()
    
    private lazy var percentageImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.image = .percentageDown
        return imgView
    }()

    //RightButton
    private lazy var buttonDropDown: UIButton = UIButton(type: .custom)
    
    //Left Image
    private lazy var leftImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.isHidden = true
        return imgView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    private func updateViewState() {
        switch currentState {
        case .normal(let title, let textFieldPlaceholder):
            setViewState(title: title, placeholder: textFieldPlaceholder, leftIcon: nil, showDropdown: false, showPercentage: false)

        case .withLeftIcon(let title, let textFieldPlaceholder, let icon):
            setViewState(title: title, placeholder: textFieldPlaceholder, leftIcon: icon, showDropdown: false, showPercentage: false)

        case .withPercentage(let title, let textFieldPlaceholder, let percent):
            setViewState(title: title, placeholder: textFieldPlaceholder, leftIcon: nil, showDropdown: false, showPercentage: true)
            percentagelabel.text = percent + "%"

        case .withIconPercentageDropdown(let title, let textFieldPlaceholder, let icon, let percent):
            setViewState(title: title, placeholder: textFieldPlaceholder, leftIcon: icon, showDropdown: true, showPercentage: true)
            percentagelabel.text = percent + "%"

        case .withDropdown(let title, let textFieldPlaceholder):
            setViewState(title: title, placeholder: textFieldPlaceholder, leftIcon: nil, showDropdown: true, showPercentage: false)
        }
    }

    private func setViewState(title: String, placeholder: String, leftIcon: UIImage?, showDropdown: Bool, showPercentage: Bool) {
        titleLabel.text = title
        textField.placeholder = placeholder
        leftImageView.isHidden = leftIcon == nil
        leftImageView.image = leftIcon
        buttonDropDown.setImage(.inputDropdown, for: .normal)
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
        setUpStackView()
        applyDefaultStyle()
        textField.delegate = self
    }
    
    func setUpStackView() {
        addSubview(stackView)
        stackView.removeAllArrangedSubviews()
        stackViewTextField.removeAllArrangedSubviews()
        stackViewWithPercentage.removeAllArrangedSubviews()
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(txtView)
        
        stackViewTextField.addArrangedSubview(leftImageView)
        stackViewTextField.addArrangedSubview(textField)
        stackViewTextField.addArrangedSubview(stackViewWithPercentage)
        
        stackViewWithPercentage.addArrangedSubview(percentagelabel)
        stackViewWithPercentage.addArrangedSubview(percentageImageView)
        
        stackViewTextField.addArrangedSubview(buttonDropDown)
        stackView.addArrangedSubview(descriptionLabel)
        txtView.addSubview(stackViewTextField)
        
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
            stackViewTextField.trailingAnchor.constraint(equalTo: txtView.trailingAnchor, constant: -14),
            
        ])
        
        // height and width constraints for leftImageView
        NSLayoutConstraint.activate([
            leftImageView.heightAnchor.constraint(equalToConstant: 20),
            leftImageView.widthAnchor.constraint(equalToConstant: 20),
        ])
        
        // height and width constraints for RightImageView
        NSLayoutConstraint.activate([
            buttonDropDown.heightAnchor.constraint(equalToConstant: 20),
            buttonDropDown.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    // MARK: - Styling
    func applyDefaultStyle() {
        titleLabel.textColor = .formItemTitle
        titleLabel.numberOfLines = 1
        titleLabel.font = .font16Medium
        titleLabel.textAlignment = .left
        
        textField.textColor = .formItemText
        descriptionLabel.textColor = .neutral_5
        textField.font = .font16Regular
        textField.layer.masksToBounds = true
        txtView.layer.borderColor = UIColor.neutral_1_5.cgColor
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
}

extension FormTextFieldView : UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        // Change the border color when the textField gains focus
        textField.layer.masksToBounds = true
        textField.textColor = .primary_7
        descriptionLabel.textColor = .primary_5
        txtView.layer.borderColor = UIColor.primary_5.cgColor
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        // Change the border color back when the textField loses focus
        textField.layer.masksToBounds = true
        textField.textColor = .formItemText
        descriptionLabel.textColor = .neutral_5
        txtView.layer.borderColor = UIColor.neutral_1_5.cgColor
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
      
    }
    
}
