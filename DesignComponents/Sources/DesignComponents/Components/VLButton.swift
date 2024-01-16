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
    case dynamic
}

public enum VLButtonImageStyle {
    case left
    case right
}

public class VLButton: UIButton {
    
    // MARK: - Properties
    public var buttonStyle: VLButtonStyle = .primary {
        didSet {
            configureUI()
        }
    }
    
    public var buttonImageStyle: VLButtonImageStyle = .left {
        didSet {
            if buttonImageStyle == .right {
                self.semanticContentAttribute = .forceRightToLeft
            } else {
                self.semanticContentAttribute = .forceLeftToRight
            }
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
    
    public var bgColor: UIColor = .white {
        didSet {
            backgroundColor = bgColor
        }
    }
    
    public var titleColor: UIColor = .primary_6 {
        didSet {
            setTitleColor(titleColor, for: .normal)
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
    
    public override var semanticContentAttribute: UISemanticContentAttribute {
        didSet {
            updateContentInsets()
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
        case .dynamic:
            break
        }
        
        if buttonStyle == .dynamic {
            if isEnabled {
                setTitleColor(titleColor, for: .normal)
                backgroundColor = bgColor
                layer.borderColor = borderColor.cgColor
            } else {
                setTitleColor(titleColor.withAlphaComponent(0.5), for: .normal)
                backgroundColor = bgColor.withAlphaComponent(0.5)
                layer.borderColor = borderColor.withAlphaComponent(0.5).cgColor
            }
            
            layer.borderWidth = borderWidth
            layer.cornerRadius = 10
        } else {
            setTitleColor(textStyle.color, for: .normal)
            backgroundColor = apperance.backgroundColor
            imageView?.tintColor = textStyle.color
            
            layer.cornerRadius = apperance.cornerRadius
            layer.borderWidth = apperance.borderWidth
            layer.borderColor = apperance.borderColor.cgColor
        }
        
        clipsToBounds = true
        
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
        updateContentInsets()
    }
    
    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        updateContentInsets()
    }
    
    func updateContentInsets() {
        if self.imageView?.image == nil || self.title(for: .normal) == nil {
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            if semanticContentAttribute == .forceLeftToRight {
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
                titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -8)
                contentEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 24)
            } else {
                imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
                titleEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
                contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            }
        }
    }
    
}
