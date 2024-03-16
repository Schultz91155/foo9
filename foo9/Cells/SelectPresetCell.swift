//
//  SelectPresetCell.swift
//  foo9
//
//  Created by Pavel Brovkin on 17.03.2024.
//

import UIKit

class SelectPresetCell: UITableViewCell {

    @IBOutlet weak var presetTitle: UILabel!
    @IBOutlet weak var presetType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell (preset: Preset){
        self.presetTitle.text = preset.title
        self.presetType.text = "\(preset.type)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
