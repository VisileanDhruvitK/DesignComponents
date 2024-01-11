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
    
    public var bgColor: UIColor = .primary_0_5 {
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
    
    /*
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    }*/
    
}
