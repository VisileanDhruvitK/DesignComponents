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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        toggleView.addTarget(self, action: #selector(toggleValueChanged(_:)), for: .valueChanged)
        toggleView.setTitle("Remember me")
        toggleView.setDescription("Save my login details for next time.")
        
        toggleView2 = ToggleView()
        toggleView2.frame = CGRect(x: 32, y: 100, width: self.view.frame.size.width - 64, height: 50)
        toggleView2.addTarget(self, action: #selector(toggleValueChanged(_:)), for: .valueChanged)
        toggleView2.setTitle("Remember me")
        toggleView2.setDescription("Save my login details for next time.")
        self.view.addSubview(toggleView2)
    }
    
    @objc func toggleValueChanged(_ sender: ToggleView) {
        sender.isOn.toggle()
        print("isON - ",sender.isOn)
    }
    
}
