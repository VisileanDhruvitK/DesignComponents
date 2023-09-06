//
//  RadioButtonVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 04/09/23.
//

import UIKit
import DesignComponents

class RadioButtonVC: UIViewController {
    
    @IBOutlet weak var radioButtons: RadioButtonView!
    @IBOutlet weak var checkBoxes: CheckBoxView!
    
    var options = [SelectionOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchOptions()
        
        radioButtons.set(options)
        radioButtons.delegate = self
        
        checkBoxes.set(options)
        checkBoxes.delegate = self
    }
    
    func fetchOptions() {
        options.removeAll()
        
        let option1 = SelectionOption(title: "One", isOn: true)
        let option2 = SelectionOption(title: "Two")
        let option3 = SelectionOption(title: "Three")
        // let option4 = SelectionOption(title: "Four")
        
        options.append(contentsOf: [option1, option2, option3])
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


extension RadioButtonVC: CheckBoxSelectionDelegate {
    
    func didSelectCheckBox(indexes: Set<Int>) {
        print("CheckBox -----------")
        indexes.forEach { index in
            print("\(options[index])")
        }
    }
    
}
