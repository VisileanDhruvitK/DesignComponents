//
//  ChipVC.swift
//  DesignComponentsDemo
//
//  Created by Meet on 11/09/23.
//

import UIKit
import DesignComponents

class ChipVC: UIViewController {
    
    @IBOutlet weak var collectionState: UICollectionView!
    @IBOutlet weak var collectionSizes: UICollectionView!
    @IBOutlet weak var collectionRole: UICollectionView!
    @IBOutlet weak var collectionShape: UICollectionView!
    
    @IBOutlet weak var chipText: ChipControl!
    @IBOutlet weak var chipTextButton: ChipControl!
    @IBOutlet weak var chipImageText: ChipControl!
    @IBOutlet weak var chipImageTextButton: ChipControl!
    
    @IBOutlet weak var chipHeightConst: NSLayoutConstraint!
    
    
    // MARK: - VARIABLES
    var stateOptions = [String]()
    var sizeOptions = [String]()
    var roleOptions = [String]()
    var shapeOptions = [String]()
    
    var stateIndex = 0
    var sizeIndex = 0
    var roleIndex = 0
    var shapeIndex = 0
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionState.register(nibWithCellClass: ChipCollectionCell.self)
        collectionSizes.register(nibWithCellClass: ChipCollectionCell.self)
        collectionRole.register(nibWithCellClass: ChipCollectionCell.self)
        collectionShape.register(nibWithCellClass: ChipCollectionCell.self)
        fetchOptions()
        
        // Create and configure the chip control
        chipText.setOption(option: ChipOption(title: "text only", chipType: .textOnly, chipStyle: .roundPA))
        chipTextButton.setOption(option: ChipOption(title: "text & btn", chipType: .withButton, chipStyle: .roundPA))
        chipTextButton.delegate = self
        
        chipImageText.setOption(option: ChipOption(image: UIImage(named: "user_Image"), title: "text image", chipType: .withImage, chipStyle: .roundPA))
        chipImageTextButton.setOption(option: ChipOption(image: UIImage(named: "user_Image"), title: "text image btn", chipType: .withImageAndButton, chipStyle: .roundPA))
        chipImageTextButton.delegate = self
    }
    
    
    // MARK: - FUNCTIONS
    func fetchOptions() {
        stateOptions = ["Enable", "Disable"]
        sizeOptions = ["Medium", "Small"]
        roleOptions = ["Project Admin", "Standard User"]
        shapeOptions = ["Round", "Square"]
        
        collectionState.reloadData()
        collectionSizes.reloadData()
        collectionRole.reloadData()
        collectionShape.reloadData()
    }
    
    @objc func radioStateSelected(_ sender: RadioButton) {
        sender.isOn.toggle()
        chipText.isEnabled = sender.isOn
        chipTextButton.isEnabled = sender.isOn
        chipImageText.isEnabled = sender.isOn
        chipImageTextButton.isEnabled = sender.isOn
    }
    
}


extension ChipVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionState:
            return stateOptions.count
        case collectionSizes:
            return sizeOptions.count
        case collectionRole:
            return roleOptions.count
        case collectionShape:
            return shapeOptions.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ChipCollectionCell.self, for: indexPath)
        var title: String = ""
        var isSelected: Bool = false
        
        switch collectionView {
        case collectionState:
            title = stateOptions[indexPath.row]
            isSelected = stateIndex == indexPath.row
        case collectionSizes:
            title = sizeOptions[indexPath.row]
            isSelected = sizeIndex == indexPath.row
        case collectionRole:
            title = roleOptions[indexPath.row]
            isSelected = roleIndex == indexPath.row
        case collectionShape:
            title = shapeOptions[indexPath.row]
            isSelected = shapeIndex == indexPath.row
        default:
            break
        }
        
        cell.configureCell(title: title, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case collectionState:
            stateIndex = indexPath.row
            collectionState.reloadData()
            
            let isEnable = stateIndex == 0
            chipText.isEnabled = isEnable
            chipTextButton.isEnabled = isEnable
            chipImageText.isEnabled = isEnable
            chipImageTextButton.isEnabled = isEnable
            
        case collectionSizes:
            sizeIndex = indexPath.row
            collectionSizes.reloadData()
            
            let isMedium = sizeIndex == 0
            chipHeightConst.constant = isMedium ? 40 : 32
            self.view.layoutIfNeeded()
            chipText.componentSize = isMedium ? .medium : .small
            chipTextButton.componentSize = isMedium ? .medium : .small
            chipImageText.componentSize = isMedium ? .medium : .small
            chipImageTextButton.componentSize = isMedium ? .medium : .small
            
        case collectionRole:
            roleIndex = indexPath.row
            collectionRole.reloadData()
            refreshStyle()
            
        case collectionShape:
            shapeIndex = indexPath.row
            collectionShape.reloadData()
            refreshStyle()
            
        default:
            break
        }
    }
    
    func refreshStyle() {
        let isPA = roleIndex == 0
        let isRound = shapeIndex == 0
        
        if isPA {
            chipText.chipStyle = isRound ? .roundPA : .squrePA
            chipTextButton.chipStyle = isRound ? .roundPA : .squrePA
            chipImageText.chipStyle = isRound ? .roundPA : .squrePA
            chipImageTextButton.chipStyle = isRound ? .roundPA : .squrePA
        } else {
            chipText.chipStyle = isRound ? .roundSU : .squreSU
            chipTextButton.chipStyle = isRound ? .roundSU : .squreSU
            chipImageText.chipStyle = isRound ? .roundSU : .squreSU
            chipImageTextButton.chipStyle = isRound ? .roundSU : .squreSU
        }
    }
    
}


extension ChipVC: ChipControlDelegate {
    
    func chipButtonClicked(sender: ChipControl) {
        sender.isSelected = false
        
        if sender == chipTextButton {
            print("chipTextButton - ", sender.isSelected)
        } else if sender == chipImageTextButton {
            print("chipImageTextButton - ", sender.isSelected)
        }
    }
    
}
