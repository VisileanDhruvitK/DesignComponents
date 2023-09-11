//
//  RightImageButton.swift
//  
//
//  Created by VisiLean Admin on 08/09/23.
//

import Foundation
import UIKit

public class RightImageButton: UIControl {
    
    // MARK: - Properties
    public var textStyle: TextStyles = TextStyles() {
        didSet {
            configureUI()
        }
    }
    
    public var apperance: Appearances = Appearances() {
        didSet {
            configureUI()
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
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            // stackView.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        configureUI()
    }
    
    private func configureUI() {
        let textStyle = isEnabled ? textStyle.enableUI : textStyle.disableUI
        let apperance = isEnabled ? apperance.enableUI : apperance.disableUI
        
        self.titleLabel.textColor = textStyle.color
        self.titleLabel.font = textStyle.font
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
    }
    
    public func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    public func setImage(_ image: UIImage?) {
        imageView.image = image
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .touchUpInside)
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)).contains(point)
    }
    
}
