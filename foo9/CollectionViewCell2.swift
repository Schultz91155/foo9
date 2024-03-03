//
//  CollectionViewCell2.swift
//  foo9
//
//  Created by Pavel Brovkin on 02.03.2024.
//

import UIKit

class CollectionViewCell2: UICollectionViewCell {

    @IBOutlet weak var titleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell (group: JSONGroups){
        self.titleLable.text = group.title
    }

}
