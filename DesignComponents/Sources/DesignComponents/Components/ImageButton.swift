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
    private var titleHeightConst: NSLayoutConstraint!
    private var imageHeightConst: NSLayoutConstraint!
    
    public var componentSize: ComponentSize = .medium {
        didSet {
            updateSize()
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
    
    public var bgColor: UIColor = .primary_0_5 {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    public var titleColor: UIColor = .primary_6 {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
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
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(viewHeight / 4))
        ])
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        
        updateSize()
        configureUI()
    }
    
    private func updateSize() {
        var viewHeight: CGFloat = componentSize == .medium ? 36 : 48
        var fontSize: FontSize = .font12
        
        switch componentSize {
        case .small:
            fontSize = .font12
            viewHeight = 36
        case .medium:
            fontSize = .font14
            viewHeight = 40
        case .large:
            fontSize = .font14
            viewHeight = 40
        case .xl:
            fontSize = .font16
            viewHeight = 48
        case .xxl:
            fontSize = .font18
            viewHeight = 60
        }
        
        if imageHeightConst != nil {
            titleHeightConst?.constant = (viewHeight / 2)
            imageHeightConst?.constant = (viewHeight / 2)
        } else {
            titleHeightConst = titleLabel.heightAnchor.constraint(equalToConstant: viewHeight / 2)
            imageHeightConst = imageView.heightAnchor.constraint(equalToConstant: viewHeight / 2)
        }
        
        NSLayoutConstraint.activate([
            imageHeightConst,
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1, constant: 1),
            titleHeightConst
        ])
        
        let font = VLFont(size: fontSize, weigth: .semibold)
        titleLabel.font = font
    }
    
    private func configureUI() {
        titleLabel.text = title
        imageView.image = image
        
        titleLabel.textColor = titleColor
        backgroundColor = bgColor
        layer.borderWidth = borderWidth
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.isHidden = imageView.image == nil
        
        if isEnabled {
            imageView.alpha = 1
            titleLabel.alpha = 1
            layer.borderColor = borderColor.cgColor
        } else {
            imageView.alpha = 0.5
            titleLabel.alpha = 0.5
            layer.borderColor = borderColor.withAlphaComponent(0.5).cgColor
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .touchUpInside)
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)).contains(point)
    }
    
}
