//
//  DynamicChipVC.swift
//  DesignComponentsDemo
//
//  Created by VisiLean Admin on 27/12/23.
//

import UIKit
import DesignComponents

class DynamicChipVC: UIViewController {
    
    @IBOutlet weak var collectionState: UICollectionView!
    @IBOutlet weak var collectionSizes: UICollectionView!
    @IBOutlet weak var collectionShape: UICollectionView!
    
    @IBOutlet weak var chipText: DynamicChipControl!
    @IBOutlet weak var chipTextButton: DynamicChipControl!
    @IBOutlet weak var chipImageText: DynamicChipControl!
    @IBOutlet weak var chipImageTextButton: DynamicChipControl!
    
    @IBOutlet weak var chipHeightConst: NSLayoutConstraint!
    
    
    // MARK: - VARIABLES
    var stateOptions = [String]()
    var sizeOptions = [String]()
    var shapeOptions = [String]()
    
    var stateIndex = 0
    var sizeIndex = 0
    var shapeIndex = 0
    
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionState.register(nibWithCellClass: ChipCollectionCell.self)
        collectionSizes.register(nibWithCellClass: ChipCollectionCell.self)
        collectionShape.register(nibWithCellClass: ChipCollectionCell.self)
        fetchOptions()
        
        // Create and configure the chip control
        chipText.setOption(option: DynamicChipOption(title: "text only", chipType: .textOnly, chipStyle: .round))
        chipTextButton.setOption(option: DynamicChipOption(title: "text and button", buttonImage: .arrowDown, chipType: .withButton, chipStyle: .round))
        chipTextButton.delegate = self
        
        chipImageTextButton.setOption(option: DynamicChipOption(image: UIImage(named: "category_icon"), title: "text, image and button", buttonImage: .arrowDown, chipType: .withImageAndButton, chipStyle: .round))
        chipImageTextButton.delegate = self
        
        // Manual Configuration of Chip
        chipImageText.chipType = .withImage
        chipImageText.image = UIImage(named: "krishna-asta-gopis")
        chipImageText.title = "text and image"
        
        
        // Add target to ChipControl
        chipText.addTarget(self, action: #selector(chipTapped(_:)), for: .valueChanged)
        chipTextButton.addTarget(self, action: #selector(chipTapped(_:)), for: .valueChanged)
        chipImageText.addTarget(self, action: #selector(chipTapped(_:)), for: .valueChanged)
        chipImageTextButton.addTarget(self, action: #selector(chipTapped(_:)), for: .valueChanged)
        
        
        chipText.titleColor = .white
        chipText.backgroundColor = .primary_6
        
        chipTextButton.titleColor = .primary_6
        chipTextButton.borderColor = .primary_6
        chipTextButton.borderWidth = 1
        chipTextButton.buttonImage = .designTask
        
        chipImageText.titleColor = .destructive_5
        chipImageText.borderColor = .destructive_5
        chipImageText.borderWidth = 1
        chipImageText.image = .highPriority
        
        chipImageTextButton.borderColor = .neutral_7
        chipImageTextButton.borderWidth = 1
        chipImageTextButton.imageTint = .red
    }
    
    
    // MARK: - FUNCTIONS
    func fetchOptions() {
        stateOptions = ["Enable", "Disable"]
        sizeOptions = ["Medium", "Small"]
        shapeOptions = ["Round", "Square"]
        
        collectionState.reloadData()
        collectionSizes.reloadData()
        collectionShape.reloadData()
    }
    
    @objc func chipTapped(_ sender: DynamicChipControl) {
        switch sender.tag {
        case 0:
            print("chipText")
        case 1:
            print("chipTextButton")
        case 2:
            print("chipImageText")
        case 3:
            print("chipImageTextButton")
        default:
            break
        }
    }
    
}


extension DynamicChipVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case collectionState:
            return stateOptions.count
        case collectionSizes:
            return sizeOptions.count
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
            
        case collectionShape:
            shapeIndex = indexPath.row
            collectionShape.reloadData()
            refreshStyle()
            
        default:
            break
        }
    }
    
    func refreshStyle() {
        let isRound = shapeIndex == 0
        chipText.chipStyle = isRound ? .round : .squre
        chipTextButton.chipStyle = isRound ? .round : .squre
        chipImageText.chipStyle = isRound ? .round : .squre
        chipImageTextButton.chipStyle = isRound ? .round : .squre
    }
    
}


extension DynamicChipVC: DynamicChipDelegate {
    
    func chipButtonClicked(sender: DynamicChipControl) {
        if sender == chipTextButton {
            print("chipTextButton")
        } else if sender == chipImageTextButton {
            print("chipImageTextButton")
        }
    }
    
}
