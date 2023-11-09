//
//  ChipControl.swift
//  
//
//  Created by Meet on 11/09/23.
//

import Foundation
import UIKit

public enum ChipType {
    case with(image: UIImage? = nil, text: String = "", isButtonHidden: Bool = true, chipStyle: ChipStyle = .roundSU)
}

public enum ChipStyle {
    case roundPA
    case roundSU
    case squrePA
    case squreSU
    
    var bgColor: UIColor {
        switch self {
            case .roundPA, .squrePA:
            return .white
            case .roundSU, .squreSU:
                return .primary_0_5
        }
    }
    
    var bgColorSelected: UIColor {
        switch self {
            case .roundPA, .squrePA:
                return .neutral_0_5
            case .roundSU, .squreSU:
                return .primary_0_2
        }
    }
}

public class ChipControl: UIControl {
    
    private var textStyle: TextStyles = TextStyles()
    private var chipStyle: ChipStyle = .roundPA
    
    private var appearance: Appearances = Appearances() {
        didSet {
            configureUI()
        }
    }
    
    public var componentSize: ComponentSize = .medium {
        didSet {
            updateSize()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            configureUI()
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            setSelectionState()
        }
    }
    
    public var chipType: ChipType = .with(text: "", isButtonHidden: false, chipStyle: .roundPA) {
        didSet {
            updateUIForChipType()
        }
    }
    
    var onRemove: (() -> Void)?
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    private let button: UIButton = UIButton(type: .custom)
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    private func setupUI() {
        addSubview(stackView)
        
        stackView.removeAllArrangedSubviews()
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(button)
        
        // Adjust stackView constraints to make imageView and button dynamic
        let topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        
        // Set dynamic width constraints on the main parent view
        leadingConstraint = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        trailingConstraint = stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        NSLayoutConstraint.activate([
            topConstraint,
            bottomConstraint,
            leadingConstraint,
            trailingConstraint,
            
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            button.heightAnchor.constraint(equalToConstant: 20),
            button.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        clipsToBounds = true
        
        //set imageView
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        
        // Allow titleLabel to determine the width
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        
        // Add target for button
        button.addTarget(self, action: #selector(removeChip), for: .touchUpInside)
        
        
        updateSize()
        updateUIForChipType()
        setSelectionState()
    }
    
    private func updateSize() {
        if componentSize == .small {
            leadingConstraint.constant = 8
            trailingConstraint.constant = -8
        } else {
            leadingConstraint.constant = 12
            trailingConstraint.constant = -12
        }
        
        switch chipStyle {
        case .roundPA, .roundSU:
            layer.cornerRadius = frame.size.height / 2
        case .squrePA, .squreSU:
            layer.cornerRadius = 10
        }
        
        let textStyle = isEnabled ? textStyle.enableUI : textStyle.disableUI
        titleLabel.font = textStyle.font
        if componentSize == .medium {
            titleLabel.font = .font16Medium
        } else {
            titleLabel.font = .font14Medium
        }
    }
    
    //set Image Of Button
    private func setButtonImage() {
        switch chipStyle {
            case .roundPA, .squrePA:
                button.setImage(VLImage(named: "close_pa"), for: .normal)
            case .roundSU, .squreSU:
                button.setImage(VLImage(named: "close_su"), for: .normal)
        }
    }
    
    //se Border of Chip
    private func setSelectionState() {
        if chipStyle == .roundPA || chipStyle == .squrePA {
            layer.borderWidth = 1
        } else {
            layer.borderWidth = isSelected ? 1 : 0
        }
        
        switch chipStyle {
        case .roundPA, .squrePA:
            backgroundColor = isSelected ? chipStyle.bgColorSelected : chipStyle.bgColor
        case .roundSU, .squreSU:
            backgroundColor = isSelected ? chipStyle.bgColorSelected : chipStyle.bgColor
        }
        
        setChipBorderColor()
    }
    
    private func configureUI() {
        let textStyle = isEnabled ? textStyle.enableUI : textStyle.disableUI
        titleLabel.textColor = textStyle.color
        // titleLabel.font = textStyle.font
        setButtonImage()
        setChipBorderColor()
        
        imageView.alpha = isEnabled ? 1 : 0.5
    }
    
    private func updateUIForChipType() {
        switch chipType {
        case .with(let image, let text, let isButtonHidden, let chipStyle):
            titleLabel.text = text
            if let img = image {
                imageView.image = img
                imageView.isHidden = false
            } else {
                imageView.isHidden = true
            }
            
            button.isHidden = isButtonHidden
            setChipStyle(chipStyles: chipStyle)
            layoutSubviews()
            
        }
    }
    
    private func setChipStyle(chipStyles: ChipStyle) {
        chipStyle = chipStyles
        switch chipStyles {
            case .roundPA:
                layer.cornerRadius = frame.size.height / 2
                layer.borderWidth = 1
                backgroundColor = isSelected ? chipStyle.bgColorSelected : chipStyle.bgColor
                textStyle = TextStyles(enableUI: .chipTitlePA, disableUI: .chipDisabledPA)
                configureUI()
                
            case .roundSU:
                layer.cornerRadius = frame.size.height / 2
                layer.borderWidth = isSelected ? 1 : 0
                backgroundColor = isSelected ? chipStyle.bgColorSelected : chipStyle.bgColor
                textStyle = TextStyles(enableUI: .chipTitleSU, disableUI: .chipDisabledSU)
                configureUI()
                
            case .squrePA:
                layer.cornerRadius = 10 // Or any other corner radius value you prefer
                layer.borderWidth = 1
                backgroundColor = isSelected ? chipStyle.bgColorSelected : chipStyle.bgColor
                textStyle = TextStyles(enableUI: .chipTitlePA, disableUI: .chipDisabledPA)
                configureUI()
                
            case .squreSU:
                layer.cornerRadius = 10 // Or any other corner radius value you prefer
                layer.borderWidth = isSelected ? 1 : 0
                backgroundColor = isSelected ? chipStyle.bgColorSelected : chipStyle.bgColor
                textStyle = TextStyles(enableUI: .chipTitleSU, disableUI: .chipDisabledSU)
                configureUI()
        }
    }
    
    private func setChipBorderColor() {
        switch chipStyle {
        case .roundPA, .squrePA:
            if isEnabled {
                layer.borderColor = isSelected ? UIColor.neutral_5.cgColor : UIColor.neutral_1_5.cgColor
            } else {
                layer.borderColor = UIColor.neutral_3.cgColor
            }
        case .roundSU, .squreSU:
            if isEnabled {
                layer.borderColor = isSelected ? UIColor.primary_6.cgColor : UIColor.clear.cgColor
            } else {
                layer.borderColor = UIColor.neutral_3.cgColor
            }
        }
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        // Handle the tap event here
        // You can perform actions like toggling the chip's selection state
        // or invoking a closure like onRemove when the chip is tapped.
        
        isSelected.toggle() // Toggle the selection state when tapped
        setSelectionState() // Update the border based on the new selection state
        
        // Trigger the onRemove closure if it's set
        if isSelected, let onRemove = onRemove {
            onRemove()
        }
    }
    
    @objc private func removeChip() {
        onRemove?()
    }
}
