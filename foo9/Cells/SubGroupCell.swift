//
//  SubGroupCell.swift
//  foo9
//
//  Created by Pavel Brovkin on 03.03.2024.
//

import UIKit

class SubGroupCell: UICollectionViewCell, UITextFieldDelegate {

    @IBOutlet weak var imageSubGroup: UIImageView!
    @IBOutlet weak var titleSubGroup: UITextField!
    @IBOutlet weak var priceSubGroup: UITextField!
    @IBOutlet weak var editBtnOutlet: UIButton!
   
    var subGroup : JSONSubGroup!
    var currentIndexPath: IndexPath!
    var currentSection: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareForReuse()
        titleSubGroup.delegate = self
        titleSubGroup.isUserInteractionEnabled = false
        priceSubGroup.isUserInteractionEnabled = false
        editBtnOutlet.isHidden = true
        
        
        // Initialization code
    }
    func setupCell(subGroup : JSONSubGroup){
        self.imageSubGroup.image = UIImage(named: subGroup.image)!
        self.titleSubGroup.text = subGroup.title
        self.priceSubGroup.text = "\(subGroup.price)"
        
    }
    
    @IBAction func editBtn(_ sender: Any) {
        titleSubGroup.isUserInteractionEnabled = false
        editBtnOutlet.isHidden = true
        NewStorage.shared.storageGroups[currentSection].subGroups[currentIndexPath.row].title = titleSubGroup.text!
        

        
        
    }
    

    

    
    
    
    
}
