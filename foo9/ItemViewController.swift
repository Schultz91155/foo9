//
//  ItemViewController.swift
//  foo9
//
//  Created by Pavel Brovkin on 08.03.2024.
//

import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet weak var imageSubGroup: UIImageView!
    @IBOutlet weak var titleSubGroup: UILabel!
    
    @IBOutlet weak var titleMainSubGroup: UILabel!
    @IBOutlet weak var mainSG: UISegmentedControl!
    
    var subGroup = JSONSubGroup(title: "", image: "", subGroups: [JSONSubGroup](), items: [JSONItem]())
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSubGroup.image = UIImage(named: subGroup.image)
        titleSubGroup.text = subGroup.title
        titleMainSubGroup.text = subGroup.subGroups.first?.title ?? ""
        mainSG.removeAllSegments()
        for (index, _) in subGroup.subGroups[0].items.enumerated(){
            mainSG.insertSegment(withTitle: subGroup.subGroups[0].items[index].title, at: index, animated: false)
        }
        
    }
    
    
 
}
