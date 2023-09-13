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
    @IBOutlet weak var Chip_Text_btn: ChipControl!
    
    @IBOutlet weak var chipWithImage: ChipControl!
    @IBOutlet weak var chip_Img_text_btn: ChipControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and configure the chip control
        chipTextonly.chipType = .withText("text only", isButtonHidden: true)
        Chip_Text_btn.chipType = .withText("text & btn", isButtonHidden: false)
        chipWithImage.chipType = .withImage(image: VLImage(named: "arrowDown") ?? UIImage(), text: "text image", isButtonHidden: true)
        chip_Img_text_btn.chipType = .withImage(image: VLImage(named: "arrowDown") ?? UIImage(), text: "text image btn", isButtonHidden: false)
        
        chip_Img_text_btn.isEnabled = false
    }

}
