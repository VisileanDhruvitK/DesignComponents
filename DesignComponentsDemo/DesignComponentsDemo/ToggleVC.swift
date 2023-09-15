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
    var toggleView2: ToggleView!
    var toggleView3: ToggleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        toggleView.addTarget(self, action: #selector(toggleValueChanged(_:)), for: .valueChanged)
        toggleView.setOption(title: "Remember me", description: "Save my login details for next time.")
        toggleView.componentSize = .extraLarge
        
        toggleView2 = ToggleView()
        toggleView2.frame = CGRect(x: 32, y: 100, width: self.view.frame.size.width - 64, height: 25)
        toggleView2.addTarget(self, action: #selector(toggleValueChanged(_:)), for: .valueChanged)
        toggleView2.setOption(title: "Remember me", description: "")
        toggleView2.componentSize = .extraLarge
        self.view.addSubview(toggleView2)
        
        toggleView3 = ToggleView()
        toggleView3.frame = CGRect(x: 32, y: self.view.frame.size.height - 200, width: self.view.frame.size.width - 64, height: 20)
        toggleView3.addTarget(self, action: #selector(toggleValueChanged(_:)), for: .valueChanged)
        toggleView3.setOption(title: "", description: "Save my login details for next time.")
        self.view.addSubview(toggleView3)
    }
    
    @objc func toggleValueChanged(_ sender: ToggleView) {
        sender.isOn.toggle()
        print("isON - ",sender.isOn)
    }
    
}
