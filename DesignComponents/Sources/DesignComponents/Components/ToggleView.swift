//
//  ToggleView.swift
//  
//
//  Created by VisiLean Admin on 11/09/23.
//

import UIKit

public class ToggleView: UIControl {
    
    // MARK: - Properties
    private var titleHeightConst: NSLayoutConstraint!
    private var imageHeightConst: NSLayoutConstraint!
    
    private var image: UIImage? = .toggleOff
    private var selectedImage: UIImage? = .toggleOn
    
    private var titleStyle: TextStyle = .toggleTitle
    private var subTitleStyle: TextStyle = .toggleSubTitle
    
    private var apperance: Appearance = Appearance()
    
    public var componentSize: ComponentSize = .medium {
        didSet {
            updateSize()
        }
    }
    
    public var identifier: String = ""
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
            titleLabel.isHidden = title.isEmpty
        }
    }
    
    public var descriptionText: String = "" {
        didSet {
            descriptionLabel.text = descriptionText
            descriptionLabel.isHidden = descriptionText.isEmpty
        }
    }
    
    public var descriptionLines: Int = 2 {
        didSet {
            descriptionLabel.numberOfLines = descriptionLines
            self.layoutIfNeeded()
        }
    }
    
    public var isOn: Bool = false {
        didSet {
            updateState()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            configureUI()
        }
    }
    
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
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .leading
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.axis = .vertical
        view.spacing = 0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(stackView)
        stackView.removeAllArrangedSubviews()
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(verticalStackView)
        stackView.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        titleLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        
        updateSize()
        configureUI()
    }
    
    private func updateSize() {
        let viewHeight: CGFloat = componentSize == .medium ? 40 : 50
        
        if imageHeightConst != nil {
            titleHeightConst?.constant = (viewHeight / 2)
            imageHeightConst?.constant = (viewHeight / 2)
        } else {
            titleHeightConst = titleLabel.heightAnchor.constraint(equalToConstant: viewHeight / 2)
            imageHeightConst = imageView.heightAnchor.constraint(equalToConstant: viewHeight / 2)
        }
        
        NSLayoutConstraint.activate([
            imageHeightConst,
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: (36/20), constant: 1),
            titleHeightConst
        ])
        
        titleLabel.font = titleStyle.font
        descriptionLabel.font = subTitleStyle.font
        
        if componentSize == .xl {
            titleLabel.font = .font16Medium
            descriptionLabel.font = .font16Regular
        } else {
            titleLabel.font = .font14Medium
            descriptionLabel.font = .font14Regular
        }
    }
    
    private func configureUI() {
        titleLabel.textColor = titleStyle.color
        descriptionLabel.textColor = subTitleStyle.color
        
        self.backgroundColor = apperance.backgroundColor
        
        layer.cornerRadius = apperance.cornerRadius
        clipsToBounds = true
        
        layer.borderWidth = apperance.borderWidth
        layer.borderColor = apperance.borderColor.cgColor
        
        if isEnabled {
            selectedImage = .toggleOn
            image = .toggleOff
        } else {
            selectedImage = .toggleOnDisabled
            image = .toggleOffDIsabled
        }
        
        updateState()
    }
    
    public func setOption(title: String, description: String) {
        titleLabel.text = title
        titleLabel.isHidden = title.isEmpty
        
        descriptionLabel.text = description
        descriptionLabel.isHidden = description.isEmpty
        
        stackView.spacing = (title.isEmpty && description.isEmpty) ? 0 : 8
    }
    
    public func setImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    private func updateState() {
        imageView.image = (isOn ? selectedImage : image)
    }
    
    func select(_ select: Bool) {
        isOn = select
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .valueChanged)
        // isOn.toggle()
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)).contains(point)
    }
    
}
