//
//  CollectionViewCell.swift
//  foo9
//
//  Created by Pavel Brovkin on 20.02.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(group : Group){
        self.image.image = UIImage(named: group.image)!
        self.title.text = group.name
    }

}
