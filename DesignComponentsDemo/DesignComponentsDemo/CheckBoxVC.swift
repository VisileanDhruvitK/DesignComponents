//
//  CheckBoxVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 08/09/23.
//

import UIKit
import DesignComponents

class CheckBoxVC: UIViewController {
    
    @IBOutlet weak var checkBoxState: CheckBox!
    @IBOutlet weak var checkBoxSizes: CheckBoxView!
    
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var checkBoxes: CheckBoxView!
    
    var sizeOptions = [CheckboxOption]()
    var radioOptions = [CheckboxOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        // checkBoxState.setOption(option: CheckboxOption(title: "Enable", selectionState: .selected))
        checkBoxState.title = "Enable"
        checkBoxState.descriptionText = "Enable / Disable \nNew line check 1 \nNew line check 2"
        checkBoxState.descriptionLines = 3
        checkBoxState.selectionState = .selected
        checkBoxState.addTarget(self, action: #selector(checkBoxStateSelected(_:)), for: .valueChanged)
        
        checkBox.setOption(option: CheckboxOption(title: "Single CheckBox", selectionState: .selected))
        checkBox.addTarget(self, action: #selector(checkBoxSelected(_:)), for: .valueChanged)
        
        fetchSizes()
        fetchOptions()
    }
    
    func fetchSizes() {
        sizeOptions.removeAll()
        
        let option1 = CheckboxOption(title: "Medium", description: "", selectionState: .selected)
        let option2 = CheckboxOption(title: "Extra Large", description: "")
        
        sizeOptions.append(contentsOf: [option1, option2])
        
        checkBoxSizes.set(sizeOptions)
        checkBoxSizes.allowMultipleSelection = false
        checkBoxSizes.tag = 1
        checkBoxSizes.delegate = self
    }
    
    func fetchOptions() {
        radioOptions.removeAll()
        
        let option1 = CheckboxOption(title: "Select One", description: "Save my login details for next time.", selectionState: .selected)
        let option2 = CheckboxOption(title: "Select Two", description: "Save my login details for next time.")
        let option3 = CheckboxOption(title: "Select Three", description: "Save my login details for next time.")
        // let option4 = SelectionOption(title: "Four")
        
        radioOptions.append(contentsOf: [option1, option2, option3])
        
        checkBoxes.set(radioOptions)
        checkBoxes.delegate = self
    }
    
    @objc func checkBoxStateSelected(_ sender: CheckBox) {
        if sender.selectionState == .selected {
            sender.selectionState = .deselected
        } else {
            sender.selectionState = .selected
        }
        
        checkBox.isEnabled = sender.selectionState == .selected
        checkBoxes.isEnabled = sender.selectionState == .selected
    }
    
    @objc func checkBoxSelected(_ sender: CheckBox) {
        if sender.selectionState == .selected {
            sender.selectionState = .deselected
        } else {
            sender.selectionState = .selected
        }
        
        print("isSelected - ",sender.selectionState)
    }
    
}

extension CheckBoxVC: CheckBoxSelectionDelegate {
    
    func didSelectCheckBox(tag: Int, indexes: Set<Int>) {
        if tag == 1 {
            let option = sizeOptions[indexes.first ?? 0]
            if option.title == "Extra Large" {
                checkBox.componentSize = .xl
                checkBoxes.componentSize = .xl
            } else {
                checkBox.componentSize = .medium
                checkBoxes.componentSize = .medium
            }
        } else {
            print("CheckBox -----------")
            indexes.forEach { index in
                print("\(radioOptions[index])")
            }
        }
    }
    
}
