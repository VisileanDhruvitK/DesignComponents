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
    
    var sizeOptions = [RadioOption]()
    var radioOptions = [RadioOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // radioState.setOption(option: RadioOption(title: "Enable", isOn: true))
        radioState.title = "Enable"
        radioState.descriptionText = "Enable / Disable"
        radioState.isOn = true
        radioState.addTarget(self, action: #selector(radioStateSelected(_:)), for: .valueChanged)
        
        radioButton.setOption(option: RadioOption(title: "Single Radio", isOn: true))
        radioButton.addTarget(self, action: #selector(radioSelected(_:)), for: .valueChanged)
        
        fetchSizes()
        fetchOptions()
    }
    
    func fetchSizes() {
        sizeOptions.removeAll()
        
        let option1 = RadioOption(title: "Medium", description: "", isOn: true)
        let option2 = RadioOption(title: "Extra Large", description: "")
        
        sizeOptions.append(contentsOf: [option1, option2])
        
        radioSizes.set(sizeOptions)
        radioSizes.tag = 1
        radioSizes.delegate = self
    }
    
    func fetchOptions() {
        radioOptions.removeAll()
        
        let option1 = RadioOption(title: "Select One", description: "Save my login details for next time.", isOn: true)
        let option2 = RadioOption(title: "Select Two", description: "Save my login details for next time.")
        let option3 = RadioOption(title: "Select Three", description: "Save my login details for next time.")
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
                radioButton.componentSize = .xl
                radioButtons.componentSize = .xl
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
