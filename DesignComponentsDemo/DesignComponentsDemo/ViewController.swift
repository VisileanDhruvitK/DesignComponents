//
//  ViewController.swift
//  DesignComponentsDemo
//
//  Created by Dhruvit Kachhiya on 11/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayMenu = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Design Components"
        arrayMenu = ["Radio Button & CheckBox", "Buttons", "FormTextField"]
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
        cell?.textLabel?.text = arrayMenu[indexPath.row]
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let aVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RadioButtonVC")
            aVC.title = arrayMenu[indexPath.row]
            self.navigationController?.pushViewController(aVC, animated: true)
            
        case 1:
            let aVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ButtonsVC")
            aVC.title = arrayMenu[indexPath.row]
            self.navigationController?.pushViewController(aVC, animated: true)
        
        case 2:
            let aVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FormTextFieldVC")
            aVC.title = arrayMenu[indexPath.row]
            self.navigationController?.pushViewController(aVC, animated: true)
            
        default:
            break
        }
    }
    
}
