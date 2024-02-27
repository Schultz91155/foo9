//
//  GroupCollectionViewCell.swift
//  foo9
//
//  Created by Pavel Brovkin on 22.02.2024.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(group : AbstractGroup){
        self.titleLabel.text = group.name
    }

}
