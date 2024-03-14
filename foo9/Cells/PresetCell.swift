//
//  PresetCell.swift
//  foo9
//
//  Created by Pavel Brovkin on 11.03.2024.
//

import UIKit

class PresetCell: UICollectionViewCell {

    @IBOutlet weak var presetTitile: UILabel!
    
    @IBOutlet weak var presetType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell( preset: Preset){
        self.presetTitile.text = preset.title
        self.presetType.text = "\(preset.type)"
        
    }

}
