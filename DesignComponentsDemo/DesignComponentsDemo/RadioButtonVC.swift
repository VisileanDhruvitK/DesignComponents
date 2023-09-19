//
//  RadioButtonVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 04/09/23.
//

import UIKit
import DesignComponents

class RadioButtonVC: UIViewController {
    
    @IBOutlet weak var radioState: RadioButton!
    @IBOutlet weak var radioSizes: RadioButtonView!
    
    @IBOutlet weak var radioButton: RadioButton!
    @IBOutlet weak var radioButtons: RadioButtonView!
    
    var sizeOptions = [SelectionOption]()
    var radioOptions = [SelectionOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        radioState.setOption(option: SelectionOption(title: "Enable", isOn: true))
        radioState.addTarget(self, action: #selector(radioStateSelected(_:)), for: .valueChanged)
        
        radioButton.setOption(option: SelectionOption(title: "Single Radio", isOn: true))
        radioButton.addTarget(self, action: #selector(radioSelected(_:)), for: .valueChanged)
        
        fetchSizes()
        fetchOptions()
    }
    
    func fetchSizes() {
        sizeOptions.removeAll()
        
        let option1 = SelectionOption(title: "Medium", description: "", isOn: true)
        let option2 = SelectionOption(title: "Extra Large", description: "")
        
        sizeOptions.append(contentsOf: [option1, option2])
        
        radioSizes.set(sizeOptions)
        radioSizes.tag = 1
        radioSizes.delegate = self
    }
    
    func fetchOptions() {
        radioOptions.removeAll()
        
        let option1 = SelectionOption(title: "Select One", description: "Save my login details for next time.", isOn: true)
        let option2 = SelectionOption(title: "Select Two", description: "Save my login details for next time.")
        let option3 = SelectionOption(title: "Select Three", description: "Save my login details for next time.")
        // let option4 = SelectionOption(title: "Four")
        
        radioOptions.append(contentsOf: [option1, option2, option3])
        
        radioButtons.set(radioOptions)
        radioButtons.delegate = self
    }
    
    @objc func radioStateSelected(_ sender: RadioButton) {
        sender.isOn.toggle()
        radioButton.isEnabled = sender.isOn
        radioButtons.isEnabled = sender.isOn
    }
    
    @objc func radioSelected(_ sender: RadioButton) {
        sender.isOn.toggle()
        print("isON - ",sender.isOn)
    }
    
}


extension RadioButtonVC: RadioSelectionDelegate {
    
    func didSelectRadioButton(tag: Int, indexes: Set<Int>) {
        if tag == 1 {
            let option = sizeOptions[indexes.first ?? 0]
            if option.title == "Extra Large" {
                radioButton.componentSize = .extraLarge
                radioButtons.componentSize = .extraLarge
            } else {
                radioButton.componentSize = .medium
                radioButtons.componentSize = .medium
            }
        } else {
            print("Radio -----------")
            indexes.forEach { index in
                print("\(radioOptions[index])")
            }
        }
    }
    
}
