//
//  VLButton.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import UIKit

public enum VLButtonStyle {
    case primary
    case secondary
    case link
}

public class VLButton: UIButton {
    
    // MARK: - Properties
    public var buttonStyle: VLButtonStyle = .primary {
        didSet {
            configureUI()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            configureUI()
        }
    }
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    private func initialize() {
        configureUI()
    }
    
    private func configureUI() {
        var textStyle: TextStyle = TextStyle()
        var apperance: Appearance = Appearance()
        
        switch buttonStyle {
        case .primary:
            textStyle = isEnabled ? .primaryButton : .primaryButtonDisabled
            apperance = isEnabled ? .primaryButton : .primaryButtonDisabled
        case .secondary:
            textStyle = isEnabled ? .secondaryButton : .secondaryButtonDisabled
            apperance = isEnabled ? .secondaryButton : .secondaryButtonDisabled
        case .link:
            textStyle = isEnabled ? .linkButton : .linkButtonDisabled
        }
        
        
        self.setTitleColor(textStyle.color, for: .normal)
        self.titleLabel?.font = textStyle.font
        self.backgroundColor = apperance.backgroundColor
        self.imageView?.tintColor = textStyle.color
        
        if apperance.cornerRadius > 0 {
            self.layer.cornerRadius = apperance.cornerRadius
            self.clipsToBounds = true
        }
        
        if apperance.borderWidth > 0 {
            self.layer.borderWidth = apperance.borderWidth
            self.layer.borderColor = apperance.borderColor.cgColor
        }
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    }
    
}
