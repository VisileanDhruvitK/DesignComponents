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
        switch arrayMenu[indexPath.row] {
        case .radio:
            let aVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RadioButtonVC")
            aVC.title = arrayMenu[indexPath.row].title
            self.navigationController?.pushViewController(aVC, animated: true)
            
        case .checkBox:
            let aVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CheckBoxVC")
            aVC.title = arrayMenu[indexPath.row].title
            self.navigationController?.pushViewController(aVC, animated: true)
            
        case .button:
            let aVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ButtonsVC")
            aVC.title = arrayMenu[indexPath.row].title
            self.navigationController?.pushViewController(aVC, animated: true)
        
        case .formTextField:
            let aVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FormTextFieldVC")
            aVC.title = arrayMenu[indexPath.row].title
            self.navigationController?.pushViewController(aVC, animated: true)
            
        case .toggle:
            let aVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ToggleVC")
            aVC.title = arrayMenu[indexPath.row].title
            self.navigationController?.pushViewController(aVC, animated: true)
        }
    }
    
}
