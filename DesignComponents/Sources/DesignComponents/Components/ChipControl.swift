//
//  ChipControl.swift
//  
//
//  Created by Meet on 11/09/23.
//

import Foundation
import UIKit

public enum ChipType {
    case withText(String, isButtonHidden: Bool)
    case withImage(image: UIImage, text: String, isButtonHidden: Bool)
    
    var text: String {
        switch self {
            case .withText(let text, _), .withImage(_, let text, _):
                return text
        }
    }
    
    var image: UIImage? {
        switch self {
            case .withText:
                return nil
            case .withImage(let image, _, _):
                return image
        }
    }
    
    var isButtonHidden: Bool {
        switch self {
            case .withText(_, let isHidden), .withImage(_, _, let isHidden):
                return isHidden
        }
    }
}


//MARK: - ChipControl
public class ChipControl: UIControl {
    
    private var textStyle: TextStyle = .chipTitle
    private var disabledTextStyle: TextStyle = .chipDisabled
    
    public override var isEnabled: Bool {
        didSet {
            configureUI()
        }
    }
    
    public var chipType: ChipType = .withText("", isButtonHidden: false) {
        didSet {
            updateUIForChipType()
        }
    }
    
    var onRemove: (() -> Void)?
    
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
        view.alignment = .fill
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: -  methods
    private func setupUI() {
        self.backgroundColor = .primary_0_2
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(button)
        
        layer.cornerRadius = self.frame.size.height / 2
        clipsToBounds = true
        
        //set imageView
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        
        button.addTarget(self, action: #selector(removeChip), for: .touchUpInside)
        
        // Remove fixed leading and trailing constraints on stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Adjust stackView constraints to make imageView and button dynamic
        let topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12)
        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        
        // Allow titleLabel to determine the width
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        
        // Set dynamic width constraints on the main parent view
        let leadingConstraint = leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -12)
        let trailingConstraint = trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 12)
        
        NSLayoutConstraint.activate([
            topConstraint,
            bottomConstraint,
            leadingConstraint,
            trailingConstraint,
            
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            button.heightAnchor.constraint(equalToConstant: 24),
            button.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        updateUIForChipType()
        configureUI()
    }
    
    private func configureUI() {
        
        if isEnabled {
            titleLabel.textColor = textStyle.color
            imageView.tintColor = textStyle.color
            titleLabel.font = textStyle.font
        } else {
            imageView.tintColor = disabledTextStyle.color
            titleLabel.font = disabledTextStyle.font
            titleLabel.textColor = disabledTextStyle.color
        }
    }
    
    private func updateUIForChipType() {
        switch chipType {
            case .withText(let text, let isButtonHidden):
                titleLabel.text = text
                imageView.isHidden = true
                button.isHidden = isButtonHidden
            case .withImage(let image, let text, let isButtonHidden):
                titleLabel.text = text
                imageView.image = image
                imageView.isHidden = false
                button.isHidden = isButtonHidden
        }
    }
    
    
    @objc private func removeChip() {
        onRemove?()
    }
}

