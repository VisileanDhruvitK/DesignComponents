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
        
        
        setTitleColor(textStyle.color, for: .normal)
        titleLabel?.font = textStyle.font
        backgroundColor = apperance.backgroundColor
        imageView?.tintColor = textStyle.color
        
        layer.cornerRadius = apperance.cornerRadius
        clipsToBounds = true
        
        layer.borderWidth = apperance.borderWidth
        layer.borderColor = apperance.borderColor.cgColor
        
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        updateSize()
    }
    
    private func updateSize() {
        var fontSize: FontSize = .font12
        
        switch componentSize {
        case .small:
            fontSize = .font12
        case .medium:
            fontSize = .font14
        case .large:
            fontSize = .font14
        case .xl:
            fontSize = .font16
        case .xxl:
            fontSize = .font18
        }
        
        let font = VLFont(size: fontSize, weigth: .semibold)
        titleLabel?.font = font
    }
    
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    }
    
}
