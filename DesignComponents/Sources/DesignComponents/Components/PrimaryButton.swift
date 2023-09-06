//
//  PrimaryButton.swift
//  DesignComponentsDemo
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import UIKit

public class PrimaryButton: UIButton {
    
    // MARK: - Properties
    public var textStyle: TextStyle = .primaryButton {
        didSet {
            configureUI()
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            self.textStyle = isEnabled ? .primaryButton : .primaryButtonDisabled
        }
    }
    
    var cornerRadius: CGFloat = 10
    var borderWidth: CGFloat = 1
    var borderColor: UIColor = UIColor.clear {
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
        self.setTitleColor(textStyle.color, for: .normal)
        self.titleLabel?.font = textStyle.font
        self.backgroundColor = textStyle.backgroundColor
        
        if self.cornerRadius > 0 {
            self.layer.cornerRadius = self.cornerRadius
            self.clipsToBounds = true
        }
        
        if borderWidth > 0 {
            self.layer.borderWidth = self.borderWidth
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
    
}
