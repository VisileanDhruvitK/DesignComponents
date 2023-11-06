//
//  ToggleVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 11/09/23.
//

import UIKit
import DesignComponents

class ToggleVC: UIViewController {
    
    @IBOutlet weak var toggleState: ToggleView!
    @IBOutlet weak var toggleSize: ToggleView!
    
    @IBOutlet weak var toggleView: ToggleView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        toggleState.isOn = true
        toggleState.setOption(title: "Enable", description: "")
        toggleState.addTarget(self, action: #selector(toggleStateSelected(_:)), for: .valueChanged)
        
        toggleSize.isOn = false
        toggleSize.setOption(title: "Extra Large", description: "")
        toggleSize.addTarget(self, action: #selector(toggleSizeSelected(_:)), for: .valueChanged)
        
        toggleView.setOption(title: "Remember me", description: "Save my login details for next time.")
        toggleView.addTarget(self, action: #selector(toggleValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func toggleStateSelected(_ sender: ToggleView) {
        sender.isOn.toggle()
        toggleView.isEnabled = sender.isOn
    }
    
    @objc func toggleSizeSelected(_ sender: ToggleView) {
        sender.isOn.toggle()
        toggleView.componentSize = toggleSize.isOn ? .xl : .medium
    }
    
    @objc func toggleValueChanged(_ sender: ToggleView) {
        sender.isOn.toggle()
        print("isON - ",sender.isOn)
    }
    
}
