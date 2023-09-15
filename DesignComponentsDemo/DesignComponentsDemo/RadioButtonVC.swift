//
//  RadioButtonVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 04/09/23.
//

import UIKit
import DesignComponents

class RadioButtonVC: UIViewController {
    
    @IBOutlet weak var radioButton: RadioButton!
    @IBOutlet weak var radioButtons: RadioButtonView!
    
    var options = [SelectionOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchOptions()
        
        radioButton.setOption(option: SelectionOption(title: "Single Radio", isOn: true))
        radioButton.addTarget(self, action: #selector(radioSelected(_:)), for: .valueChanged)
        
        radioButtons.set(options)
        radioButtons.delegate = self
    }
    
    func fetchOptions() {
        options.removeAll()
        
        let option1 = SelectionOption(title: "Select One", description: "Save my login details for next time.", isOn: true)
        let option2 = SelectionOption(title: "Select Two", description: "Save my login details for next time.")
        let option3 = SelectionOption(title: "Select Three", description: "Save my login details for next time.")
        // let option4 = SelectionOption(title: "Four")
        
        options.append(contentsOf: [option1, option2, option3])
    }
    
    @objc func radioSelected(_ sender: RadioButton) {
        sender.isOn.toggle()
        print("isON - ",sender.isOn)
    }
    
}


extension RadioButtonVC: RadioSelectionDelegate {
    
    func didSelectRadioButton(indexes: Set<Int>) {
        print("Radio -----------")
        indexes.forEach { index in
            print("\(options[index])")
        }
    }
    
}
