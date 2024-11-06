//
//  ChipControl.swift
//  
//
//  Created by Meet on 11/09/23.
//

import Foundation
import UIKit

public struct ChipOption {
    public var image: UIImage? = nil
    public var title: String = ""
    public var buttonImage: UIImage? = nil
    public var isSelected: Bool = false
    public var isEnabled: Bool = false
    public var chipType: ChipType = .textOnly
    public var chipStyle: ChipStyle = .roundPA
    public var identifier: String = ""
    
    public init(image: UIImage? = nil, title: String, buttonImage: UIImage? = nil, isSelected: Bool = false, isEnabled: Bool = true, chipType: ChipType = .textOnly, chipStyle: ChipStyle = .roundPA, identifier: String = "") {
        self.image = image
        self.title = title
        self.buttonImage = buttonImage
        self.isSelected = isSelected
        self.isEnabled = isEnabled
        self.chipType = chipType
        self.chipStyle = chipStyle
        self.identifier = identifier
    }
    
}

public enum ChipType {
    case textOnly
    case withImage
    case withButton
    case withImageAndButton
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

public protocol ChipControlDelegate: AnyObject {
    func chipButtonClicked(sender: ChipControl)
}

public class ChipControl: UIControl {
    
    private var textStyle: TextStyles = TextStyles()
    
    private var appearance: Appearances = Appearances() {
        didSet {
            configureUI()
        }
    }
    
    public var identifier: String = ""
    
    public var image: UIImage? = nil {
        didSet {
            imageView.image = image
        }
    }
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
            titleLabel.isHidden = title.isEmpty
        }
    }
    
    public var buttonImage: UIImage? = nil {
        didSet {
            button.setImage(buttonImage, for: .normal)
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
    
    public var chipStyle: ChipStyle = .roundPA {
        didSet {
            setChipStyle()
        }
    }
    
    public var chipType: ChipType = .textOnly {
        didSet {
            setChipType()
        }
    }
    
    public weak var delegate: ChipControlDelegate?
    
    private var leadingConstraint: NSLayoutConstraint!
    private var trailingConstraint: NSLayoutConstraint!
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
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
    
    private let button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.clipsToBounds = true
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        switch chipStyle {
        case .roundPA, .roundSU:
            layer.cornerRadius = frame.size.height / 2
        case .squrePA, .squreSU:
            layer.cornerRadius = 10
        }
    }
    
    private func setupUI() {
        addSubview(stackView)
        
        stackView.removeAllArrangedSubviews()
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(button)
        
        // Adjust stackView constraints to make imageView and button dynamic
        topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8)
        bottomConstraint = stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        
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
        
        imageView.layer.cornerRadius = 12
        
        // Allow titleLabel to determine the width
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        
        // Add target for button
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        updateSize()
        setChipStyle()
        setChipType()
        setSelectionState()
    }
    
    private func updateSize() {
        if componentSize == .small {
            topConstraint.constant = 4
            bottomConstraint.constant = -4
        } else {
            topConstraint.constant = 8
            bottomConstraint.constant = -8
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
        
        setChipType()
    }
    
    // Set button image
    private func setButtonImage() {
        if let btnImage = buttonImage {
            button.setImage(btnImage, for: .normal)
        } else {
            switch chipStyle {
            case .roundPA, .squrePA:
                button.setImage(VLImage(named: "close_pa"), for: .normal)
            case .roundSU, .squreSU:
                button.setImage(VLImage(named: "close_su"), for: .normal)
            }
        }
    }
    
    // Handle selection state
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
    
    // Update UI based on Enable/Disable state
    private func configureUI() {
        let textStyle = isEnabled ? textStyle.enableUI : textStyle.disableUI
        titleLabel.textColor = textStyle.color
        
        setButtonImage()
        setChipBorderColor()
        
        imageView.alpha = isEnabled ? 1 : 0.5
        button.alpha = isEnabled ? 1 : 0.5
    }
    
    // Update UI based on chip type
    private func setChipType() {
        let isRound = (chipStyle == .roundPA || chipStyle == .roundSU)
        
        leadingConstraint.constant = componentSize == .small ? 4 : 8
        trailingConstraint.constant = componentSize == .small ? -4 : -8
        
        imageView.isHidden = true
        button.isHidden = true
        
        switch chipType {
        case .textOnly:
            if isRound {
                leadingConstraint.constant = 12
                trailingConstraint.constant = -12
            } else {
                leadingConstraint.constant = 8
                trailingConstraint.constant = -8
            }
            
        case .withImage:
            imageView.isHidden = false
            trailingConstraint.constant = isRound ? -12 : -8
            
        case .withButton:
            button.isHidden = false
            leadingConstraint.constant = isRound ? 12 : 8
            
        case .withImageAndButton:
            imageView.isHidden = false
            button.isHidden = false
        }
    }
    
    // Update UI based on chip style
    private func setChipStyle() {
        switch chipStyle {
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
    
    // Set chip border
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
    
    // Set chip data
    public func setOption(option: ChipOption) {
        identifier = option.identifier
        
        imageView.image = option.image
        
        titleLabel.text = option.title
        titleLabel.isHidden = option.title.isEmpty
        
        buttonImage = option.buttonImage
        
        isSelected = option.isSelected
        
        isEnabled = option.isEnabled
        isUserInteractionEnabled = option.isEnabled
        
        chipType = option.chipType
        chipStyle = option.chipStyle
        layoutSubviews()
    }
    
    // button click event
    @objc private func buttonClicked() {
        delegate?.chipButtonClicked(sender: self)
    }
    
    // Handle chip touch
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .valueChanged)
        // isSelected.toggle()
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)).contains(point)
    }
}
