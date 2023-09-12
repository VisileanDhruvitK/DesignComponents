//
//  ChipControl.swift
//  
//
//  Created by Meet on 11/09/23.
//

import Foundation
import UIKit

import UIKit

public enum ChipType {
    case withText(String)
    case withImage(image: UIImage, text: String)
    case withButton(String)

    var text: String {
        switch self {
        case .withText(let text):
            return text
        case .withImage(_, let text):
            return text
        case .withButton(let text):
            return text
        }
    }

    var image: UIImage? {
        switch self {
        case .withText:
            return nil
        case .withImage(let image, _):
            return image
        case .withButton:
            return nil
        }
    }
}


public class ChipControl: UIControl {
    
    public var chipType: ChipType = .withText("") {
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
        label.textAlignment = .left
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
    
    private let Button: UIButton = UIButton(type: .custom)
    
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
        stackView.addArrangedSubview(Button)
        
        Button.backgroundColor = .cyan
        
        layer.cornerRadius = self.frame.size.height / 2
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        
        clipsToBounds = true
        
        Button.addTarget(self, action: #selector(removeChip), for: .touchUpInside)

        // Remove fixed leading and trailing constraints on stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Adjust stackView constraints to make imageView and Button dynamic
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
            
            Button.heightAnchor.constraint(equalToConstant: 24),
            Button.widthAnchor.constraint(equalToConstant: 24)
        ])

        updateUIForChipType()
    }




    private func updateUIForChipType() {
        switch chipType {
        case .withText(let text):
            titleLabel.text = text
            imageView.isHidden = true
        case .withImage(let image, let text):
            titleLabel.text = text
            imageView.image = image
            imageView.isHidden = false
        case .withButton(let text):
            titleLabel.text = text
            imageView.isHidden = true
        }
    }


    @objc private func removeChip() {
        onRemove?()
    }
}

