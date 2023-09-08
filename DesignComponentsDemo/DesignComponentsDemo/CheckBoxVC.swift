//
//  CheckBoxVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 08/09/23.
//

import UIKit
import DesignComponents

class CheckBoxVC: UIViewController {
    
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var checkBoxes: CheckBoxView!
    
    var options = [SelectionOption]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        fetchOptions()
        
        checkBox.setOption(option: SelectionOption(title: "Single CheckBox", isOn: true))
        checkBox.addTarget(self, action: #selector(checkBoxSelected(_:)), for: .valueChanged)
        
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
    
    @objc func checkBoxSelected(_ sender: RadioButton) {
        sender.isOn.toggle()
        print("isON - ",sender.isOn)
    }
    
}

extension CheckBoxVC: CheckBoxSelectionDelegate {
    
    func didSelectCheckBox(indexes: Set<Int>) {
        print("CheckBox -----------")
        indexes.forEach { index in
            print("\(options[index])")
        }
    }
    
}
