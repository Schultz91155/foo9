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
    
    @IBOutlet weak var sizeSegmentedControl: UISegmentedControl!
    let arr1 = ["small", "medium", "large"]
    let arr2 = ["traditional", "slim"]
    var subGroup = JSONSubGroup(title: "", image: "", subGroups: [JSONSubGroup](), items: [JSONItem]())
    var f = true
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSubGroup.image = UIImage(named: subGroup.image)
        titleSubGroup.text = subGroup.title
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func changeSG(_ sender: Any) {
        
        if f {
            sizeSegmentedControl.removeAllSegments()
            for (index, title) in arr1.enumerated(){
                sizeSegmentedControl.insertSegment(withTitle: title, at: index, animated: true)
            }
            f = false
        } else{
            sizeSegmentedControl.removeAllSegments()
            for (index, title) in arr2.enumerated(){
                sizeSegmentedControl.insertSegment(withTitle: title, at: index, animated: true)
            }
            f = true
        }
        
        
    }
}
