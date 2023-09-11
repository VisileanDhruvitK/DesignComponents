//
//  ToggleVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 11/09/23.
//

import UIKit
import DesignComponents

class ToggleVC: UIViewController {
    
    @IBOutlet weak var toggleView: ToggleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        toggleView.addTarget(self, action: #selector(toggleValueChanged(_:)), for: .valueChanged)
        toggleView.setTitle("Remember me")
        toggleView.setDescription("Save my login details for next time.")
    }
    
    @objc func toggleValueChanged(_ sender: ToggleView) {
        sender.isOn.toggle()
        print("isON - ",sender.isOn)
    }
    
}
