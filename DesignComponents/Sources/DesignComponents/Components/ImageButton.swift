//
//  ImageButton.swift
//  
//
//  Created by VisiLean Admin on 08/09/23.
//

import Foundation
import UIKit

public enum ImageButtonStyle {
    case leftImage
    case rightImage
}

public class ImageButton: UIControl {
    
    // MARK: - Properties
    public var componentSize: ComponentSize = .medium {
        didSet {
            setup()
        }
    }
    
    public var buttonStyle: ImageButtonStyle = .leftImage {
        didSet {
            setup()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            configureUI()
        }
    }
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var image: UIImage? {
        didSet {
            imageView.image = image
            imageView.isHidden = imageView.image == nil
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
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .center
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 8
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
        stackView.removeFromSuperview()
        addSubview(stackView)
        if buttonStyle == .leftImage {
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(titleLabel)
        } else {
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(imageView)
        }
        
        let viewHeight: CGFloat = componentSize == .medium ? 36 : 48
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: (viewHeight / 4)),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(viewHeight / 4)),
            
            imageView.heightAnchor.constraint(equalToConstant: viewHeight / 2),
            imageView.widthAnchor.constraint(equalToConstant: viewHeight / 2)
        ])
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        
        configureUI()
    }
    
    private func configureUI() {
        titleLabel.text = title
        imageView.image = image
        
        let textStyle: TextStyle = isEnabled ? .secondaryImageButton : .secondaryImageButtonDisabled
        let apperance: Appearance = isEnabled ? .secondaryImageButton : .secondaryImageButtonDisabled
        
        self.titleLabel.textColor = textStyle.color
        self.titleLabel.font = textStyle.font
        self.titleLabel.textAlignment = textStyle.textAlignment
        self.backgroundColor = apperance.backgroundColor
        self.imageView.tintColor = textStyle.color
        
        if apperance.cornerRadius > 0 {
            self.layer.cornerRadius = apperance.cornerRadius
            self.clipsToBounds = true
        }
        
        if apperance.borderWidth > 0 {
            self.layer.borderWidth = apperance.borderWidth
            self.layer.borderColor = apperance.borderColor.cgColor
        }
        
        imageView.isHidden = imageView.image == nil
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .touchUpInside)
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)).contains(point)
    }
    
}
