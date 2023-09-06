//
//  CheckBoxView.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 05/09/23.
//

import UIKit

public protocol CheckBoxSelectionDelegate: AnyObject {
    func didSelectCheckBox(indexes: Set<Int>)
}

extension CheckBoxSelectionDelegate {
    func calculateCheckBoxViewHeight(height: CGFloat) {}
}

public class CheckBoxView: UIView {
    
    public var selectedIndexes = Set<Int>()
    var allowMultipleSelection = true
    
    public var delegate: CheckBoxSelectionDelegate?
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alignment = .fill
        view.distribution = .fillEqually
        view.axis = .vertical
        view.spacing = 15
        return view
    }()
    
    private var checkBoxViews = [CheckBox]()
    
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
        checkBoxViews.removeAll()
        stackView.removeAllArrangedSubviews()
        
        for (index, option) in options.enumerated() {
            let radioView: CheckBox = {
                let view = CheckBox()
                view.tag = index
                view.setOption(option: option)
                view.addTarget(self, action: #selector(checkBoxSelected(_:)), for: .valueChanged)
                return view
            }()
            stackView.addArrangedSubview(radioView)
            checkBoxViews.append(radioView)
        }
        
        for (index, option) in options.enumerated() {
            if option.isOn {
                selectedIndexes.insert(index)
            }
        }
    }
    
    @objc private func checkBoxSelected(_ sender: CheckBox) {
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
        
        checkBoxViews.forEach {
            if let _ = selectedIndexes.firstIndex(of: $0.tag) {
                $0.select(true)
            } else {
                $0.select(false)
            }
        }
        
        self.delegate?.didSelectCheckBox(indexes: selectedIndexes)
    }
    
}
