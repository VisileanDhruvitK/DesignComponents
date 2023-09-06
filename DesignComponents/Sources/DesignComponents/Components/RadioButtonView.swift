//
//  RadioButtonView.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 04/09/23.
//

import UIKit

public protocol RadioSelectionDelegate: AnyObject {
    func didSelectRadioButton(indexes: Set<Int>)
}

extension RadioSelectionDelegate {
    func calculateRadioViewHeight(height: CGFloat) {}
}

public class RadioButtonView: UIView {
    
    var selectedIndexes = Set<Int>()
    var allowMultipleSelection = false
    
    public var delegate: RadioSelectionDelegate?
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .vertical
        view.spacing = 15
        return view
    }()
    
    private var radioViews = [RadioButton]()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    public func set(_ options: [SelectionOption]) {
        radioViews.removeAll()
        stackView.removeAllArrangedSubviews()
        
        for (index, option) in options.enumerated() {
            let radioView: RadioButton = {
                let view = RadioButton()
                view.tag = index
                view.setOption(option: option)
                view.addTarget(self, action: #selector(radioSelected(_:)), for: .valueChanged)
                return view
            }()
            stackView.addArrangedSubview(radioView)
            radioViews.append(radioView)
        }
        
        for (index, option) in options.enumerated() {
            if option.isOn {
                selectedIndexes.insert(index)
            }
        }
    }
    
    @objc private func radioSelected(_ sender: RadioButton) {
        if allowMultipleSelection {
            if let selectedIndex = selectedIndexes.firstIndex(of: sender.tag) {
                selectedIndexes.remove(at: selectedIndex)
            } else {
                selectedIndexes.insert(sender.tag)
            }
        } else {
            selectedIndexes.removeAll()
            selectedIndexes.insert(sender.tag)
        }
        
        radioViews.forEach {
            if let _ = selectedIndexes.firstIndex(of: $0.tag) {
                $0.select(true)
            } else {
                $0.select(false)
            }
        }
        
        self.delegate?.didSelectRadioButton(indexes: selectedIndexes)
    }
    
}

extension UIStackView {
    func removeAllArrangedSubviews() {
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
