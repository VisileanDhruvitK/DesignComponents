//
//  ToggleView.swift
//  
//
//  Created by VisiLean Admin on 11/09/23.
//

import UIKit

public class ToggleView: UIControl {
    
    // MARK: - Properties
    private var image: UIImage? = .toggleOff
    private var selectedImage: UIImage? = .toggleOn
    
    private var titleStyle: TextStyle = .toggleTitle
    private var subTitleStyle: TextStyle = .toggleSubTitle
    
    private var apperance: Appearance = Appearance()
    
    public override var isEnabled: Bool {
        didSet {
            configureUI()
        }
    }
    
    public var isOn: Bool = false {
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
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(verticalStackView)
        stackView.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 36),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        descriptionLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        
        configureUI()
    }
    
    private func configureUI() {
        self.titleLabel.textColor = titleStyle.color
        self.titleLabel.font = titleStyle.font
        
        self.descriptionLabel.textColor = subTitleStyle.color
        self.descriptionLabel.font = subTitleStyle.font
        
        self.backgroundColor = apperance.backgroundColor
        
        if apperance.cornerRadius > 0 {
            self.layer.cornerRadius = apperance.cornerRadius
            self.clipsToBounds = true
        }
        
        if apperance.borderWidth > 0 {
            self.layer.borderWidth = apperance.borderWidth
            self.layer.borderColor = apperance.borderColor.cgColor
        }
        
        if isEnabled {
            self.selectedImage = .toggleOn
            self.image = .toggleOff
        } else {
            self.selectedImage = .toggleOnDisabled
            self.image = .toggleOffDIsabled
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
