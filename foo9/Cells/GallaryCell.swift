//
//  GallaryCollectionViewCell.swift
//  foo9
//
//  Created by Pavel Brovkin on 04.03.2024.
//

import UIKit

class GallaryCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell (image : String){
        self.imageView.image = UIImage(named: image)!
        self.title.text = image.capitalized
    }

}
