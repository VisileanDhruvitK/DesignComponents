//
//  RadioButton.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 01/09/23.
//

import UIKit

public struct RadioOption {
    public var title: String = ""
    public var description: String = ""
    public var isOn: Bool = false
    public var isEnabled: Bool = false
    
    public init(title: String, description: String = "", isOn: Bool = false, isEnabled: Bool = true) {
        self.title = title
        self.description = description
        self.isOn = isOn
        self.isEnabled = isEnabled
    }
    
}

public class RadioButton: UIControl {
    
    private var image: UIImage? = .radio
    private var selectedImage: UIImage? = .radioSelected
    
    private var titleStyle: TextStyle = .checkBoxTitle
    private var subTitleStyle: TextStyle = .toggleSubTitle
    
    private var apperance: Appearance = Appearance()
    
    public var componentSize: ComponentSize = .medium {
        didSet {
            setup()
        }
    }
    
    public var isOn: Bool = false {
        didSet {
            updateState()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            updateState()
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
        label.numberOfLines = 1
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
        view.distribution = .fillEqually
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
        
        let viewHeight: CGFloat = componentSize == .medium ? 40 : 50
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: viewHeight / 2),
            imageView.widthAnchor.constraint(equalToConstant: viewHeight / 2),
            
            titleLabel.heightAnchor.constraint(equalToConstant: viewHeight / 2)
        ])
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        titleLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        
        setupUI()
        updateState()
    }
    
    private func setupUI() {
        titleLabel.textColor = titleStyle.color
        descriptionLabel.textColor = subTitleStyle.color
        
        titleLabel.font = titleStyle.font
        descriptionLabel.font = subTitleStyle.font
        
        if componentSize == .xl {
            titleLabel.font = .font16Medium
            descriptionLabel.font = .font16Regular
        }
        
        backgroundColor = apperance.backgroundColor
        
        layer.cornerRadius = apperance.cornerRadius
        clipsToBounds = true
        
        layer.borderWidth = apperance.borderWidth
        layer.borderColor = apperance.borderColor.cgColor
        
        imageView.tintColor = isEnabled ? .primary_5 : .primary_2
    }
    
    private func updateState() {
        imageView.image = (isOn ? selectedImage : image)
        imageView.tintColor = isEnabled ? .primary_5 : .primary_2
    }
    
    public func setOption(option: RadioOption) {
        titleLabel.text = option.title
        titleLabel.isHidden = option.title.isEmpty
        
        descriptionLabel.text = option.description
        descriptionLabel.isHidden = option.description.isEmpty
        
        stackView.spacing = (option.title.isEmpty && option.description.isEmpty) ? 0 : 8
        
        isOn = option.isOn
        isEnabled = option.isEnabled
        isUserInteractionEnabled = option.isEnabled
        
        setupUI()
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
