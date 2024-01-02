//
//  ViewController.swift
//  DesignComponentsDemo
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import UIKit

enum ControlType: CaseIterable {
    case radio
    case checkBox
    case button
    case formTextField
    case toggle
    case chip
    case dynamicChip
    case otpInputView
    
    var title: String {
        switch self {
        case .radio:
            return "Radio Button"
        case .checkBox:
            return "CheckBox"
        case .button:
            return "Buttons"
        case .formTextField:
            return "FormTextField"
        case .toggle:
            return "Toggle"
        case .chip:
            return "Chip"
        case .dynamicChip:
            return "Dynamic Chip"
        case .otpInputView:
            return "OTP Input View"
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayMenu = ControlType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Design Components"
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        
        cell?.selectionStyle = .none
        cell?.textLabel?.text = arrayMenu[indexPath.row].title
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = arrayMenu[indexPath.row]
        
        switch menuItem {
        case .radio:
            pushViewController(withIdentifier: "RadioButtonVC", title: menuItem.title)
            
        case .checkBox:
            pushViewController(withIdentifier: "CheckBoxVC", title: menuItem.title)
            
        case .button:
            pushViewController(withIdentifier: "ButtonsVC", title: menuItem.title)
            
        case .formTextField:
            pushViewController(withIdentifier: "FormTextFieldVC", title: menuItem.title)
            
        case .toggle:
            pushViewController(withIdentifier: "ToggleVC", title: menuItem.title)
            
        case .chip:
            pushViewController(withIdentifier: "ChipVC", title: menuItem.title)
            
        case .dynamicChip:
            pushViewController(withIdentifier: "DynamicChipVC", title: menuItem.title)
            
        case .otpInputView:
            pushViewController(withIdentifier: "OTPInputVC", title: menuItem.title)
        }
    }
    
    func pushViewController(withIdentifier identifier: String, title: String) {
        let aVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
        aVC.title = title
        self.navigationController?.pushViewController(aVC, animated: true)
    }
}
