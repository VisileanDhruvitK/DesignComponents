//
//  DynamicChipControl.swift
//
//
//  Created by VisiLean Admin on 27/12/23.
//

import Foundation
import UIKit

public struct DynamicChipOption {
    public var image: UIImage? = nil
    public var title: String = ""
    public var isEnabled: Bool = false
    public var chipType: ChipType = .textOnly
    public var chipStyle: DynamicChipStyle = .round
    public var buttonImage: UIImage? = nil
    
    public init(image: UIImage? = nil, title: String, buttonImage: UIImage? = nil, isEnabled: Bool = true, chipType: ChipType = .textOnly, chipStyle: DynamicChipStyle = .round) {
        self.image = image
        self.title = title
        self.buttonImage = buttonImage
        self.isEnabled = isEnabled
        self.chipType = chipType
        self.chipStyle = chipStyle
    }
    
}

public enum DynamicChipStyle {
    case round
    case squre
}

public protocol DynamicChipDelegate: AnyObject {
    func chipButtonClicked(sender: DynamicChipControl)
}

public class DynamicChipControl: UIControl {
    
    public var imageTint: UIColor? = nil {
        didSet {
            imageView.tintColor = imageTint
        }
    }
    
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
    
    public var titleColor: UIColor = .neutral_7 {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    public var buttonImage: UIImage? {
        didSet {
            button.setImage(buttonImage, for: .normal)
        }
    }
    
    public var borderColor: UIColor = .neutral_7 {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    public var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
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
    
    public var chipStyle: DynamicChipStyle = .round {
        didSet {
            configureUI()
        }
    }
    
    public var chipType: ChipType = .textOnly {
        didSet {
            setChipType()
        }
    }
    
    public weak var delegate: DynamicChipDelegate?
    
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
        case .round:
            layer.cornerRadius = frame.size.height / 2
        case .squre:
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
        configureUI()
        setChipType()
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
        case .round:
            layer.cornerRadius = frame.size.height / 2
        case .squre:
            layer.cornerRadius = 10
        }
        
        if componentSize == .medium {
            titleLabel.font = .font16Medium
        } else {
            titleLabel.font = .font14Medium
        }
        
        setChipType()
    }
    
    private func configureUI() {
        titleLabel.textColor = titleColor
        button.setImage(buttonImage, for: .normal)
        
        switch chipStyle {
        case .round:
            layer.cornerRadius = frame.size.height / 2
        case .squre:
            layer.cornerRadius = 10
        }
        
        titleLabel.alpha = isEnabled ? 1 : 0.5
        imageView.alpha = isEnabled ? 1 : 0.5
        button.alpha = isEnabled ? 1 : 0.5
    }
    
    private func setChipType() {
        let isRound = (chipStyle == .round)
        
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
    
    public func setOption(option: DynamicChipOption) {
        imageView.image = option.image
        
        titleLabel.text = option.title
        titleLabel.isHidden = option.title.isEmpty
        
        isEnabled = option.isEnabled
        isUserInteractionEnabled = option.isEnabled
        
        chipType = option.chipType
        chipStyle = option.chipStyle
        layoutSubviews()
        
        buttonImage = option.buttonImage
    }
    
    @objc private func buttonClicked() {
        delegate?.chipButtonClicked(sender: self)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .valueChanged)
        // isSelected.toggle()
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)).contains(point)
    }
}
