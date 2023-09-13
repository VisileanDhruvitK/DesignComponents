//
//  CheckBox.swift
//  DesignComponents
//
//  Created by Dhruvit Kachhiya on 05/09/23.
//

import UIKit

public struct SelectionOption {
    var title: String = ""
    var isOn: Bool = false
    var isEnabled: Bool = false
    
    public init(title: String, isOn: Bool = false, isEnabled: Bool = true) {
        self.title = title
        self.isOn = isOn
        self.isEnabled = isEnabled
    }
    
}

public class CheckBox: UIControl {
    
    private var textStyle: TextStyle = .checkBox
    private var disabledTextStyle: TextStyle = .checkBoxDisabled
    
    private var image: UIImage? = .checkBox
    private var selectedImage: UIImage? = .checkBoxSelected
    
    var title: String = ""
    
    public var isOn: Bool = false {
        didSet {
            updateState()
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
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        setupUI()
        updateState()
    }
    
    private func setupUI() {
        titleLabel.textColor = textStyle.color
        
        if isEnabled {
            imageView.tintColor = textStyle.color
            titleLabel.font = textStyle.font
        } else {
            imageView.tintColor = disabledTextStyle.color
            titleLabel.font = disabledTextStyle.font
        }
    }
    
    private func updateState() {
        imageView.image = (isOn ? selectedImage : image)
    }
    
    public func setOption(option: SelectionOption) {
        titleLabel.text = option.title
        isOn = option.isOn
        isEnabled = option.isEnabled
        isUserInteractionEnabled = option.isEnabled
        
        setupUI()
    }
    
    func select(_ select: Bool) {
        isOn = select
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        sendActions(for: .valueChanged)
        // isOn.toggle()
    }
    
    public override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.inset(by: UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)).contains(point)
    }
    
}
