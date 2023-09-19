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
    
    var sizeOptions = [SelectionOption]()
    var radioOptions = [SelectionOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        checkBoxState.setOption(option: SelectionOption(title: "Enable", isOn: true))
        checkBoxState.addTarget(self, action: #selector(checkBoxStateSelected(_:)), for: .valueChanged)
        
        checkBox.setOption(option: SelectionOption(title: "Single CheckBox", isOn: true))
        checkBox.addTarget(self, action: #selector(checkBoxSelected(_:)), for: .valueChanged)
        
        fetchSizes()
        fetchOptions()
    }
    
    func fetchSizes() {
        sizeOptions.removeAll()
        
        let option1 = SelectionOption(title: "Medium", description: "", isOn: true)
        let option2 = SelectionOption(title: "Extra Large", description: "")
        
        sizeOptions.append(contentsOf: [option1, option2])
        
        checkBoxSizes.set(sizeOptions)
        checkBoxSizes.allowMultipleSelection = false
        checkBoxSizes.tag = 1
        checkBoxSizes.delegate = self
    }
    
    func fetchOptions() {
        radioOptions.removeAll()
        
        let option1 = SelectionOption(title: "Select One", description: "Save my login details for next time.", isOn: true)
        let option2 = SelectionOption(title: "Select Two", description: "Save my login details for next time.")
        let option3 = SelectionOption(title: "Select Three", description: "Save my login details for next time.")
        // let option4 = SelectionOption(title: "Four")
        
        radioOptions.append(contentsOf: [option1, option2, option3])
        
        checkBoxes.set(radioOptions)
        checkBoxes.delegate = self
    }
    
    @objc func checkBoxStateSelected(_ sender: RadioButton) {
        sender.isOn.toggle()
        checkBox.isEnabled = sender.isOn
        checkBoxes.isEnabled = sender.isOn
    }
    
    @objc func checkBoxSelected(_ sender: CheckBox) {
        sender.isOn.toggle()
        print("isON - ",sender.isOn)
    }
    
}

extension CheckBoxVC: CheckBoxSelectionDelegate {
    
    func didSelectCheckBox(tag: Int, indexes: Set<Int>) {
        if tag == 1 {
            let option = sizeOptions[indexes.first ?? 0]
            if option.title == "Extra Large" {
                checkBox.componentSize = .extraLarge
                checkBoxes.componentSize = .extraLarge
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
