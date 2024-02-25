//
//  FullViewController.swift
//  foo9
//
//  Created by Pavel Brovkin on 20.02.2024.
//

import UIKit

class FullViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dough: UISegmentedControl!
    @IBOutlet weak var size: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    var doughSectionIndex = 0
    var sizeSectionIndex = 1
    lazy var currentPizza = group.groups![doughSectionIndex].items![sizeSectionIndex] as! Pizza
    
    var group = Group(type: .pizza, name: "block", image: "Block")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.image.image = UIImage(named: group.image)!
        
        titleLabel.text = group.groups![doughSectionIndex].items![sizeSectionIndex].title
        dough.addTarget(self, action: #selector(doughChanged(sender: )), for: .valueChanged)
        size.addTarget(self, action: #selector(sizeChanged(sender: )), for: .valueChanged)
        

    }
    
    @objc func doughChanged (sender : UISegmentedControl){
        doughSectionIndex = sender.selectedSegmentIndex
        updateLabel()
    }
    @objc func sizeChanged (sender : UISegmentedControl){
        sizeSectionIndex = sender.selectedSegmentIndex
        updateLabel()
    }
    func updateLabel(){
        currentPizza = group.groups![doughSectionIndex].items![sizeSectionIndex] as! Pizza
        titleLabel.text = group.groups![doughSectionIndex].items![sizeSectionIndex].title
    }
}
