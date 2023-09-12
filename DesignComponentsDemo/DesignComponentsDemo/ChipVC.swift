//
//  ChipVC.swift
//  DesignComponentsDemo
//
//  Created by Meet on 11/09/23.
//

import UIKit
import DesignComponents

class ChipVC: UIViewController {

    @IBOutlet weak var chipTextonly: ChipControl!
    @IBOutlet weak var chipWithImage: ChipControl!
    @IBOutlet weak var chipwithCloseBTN: ChipControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and configure the chip control
        chipTextonly.chipType = .withText("Text Chip")
        chipWithImage.chipType = .withImage(image: VLImage(named: "arrowDown") ?? UIImage(), text: "with image")
        chipwithCloseBTN.chipType = .withButton("Close Chip")
    
    }

}
