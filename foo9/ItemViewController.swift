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
    @IBOutlet weak var titleSecondarySubGroup: UILabel!
    @IBOutlet weak var secondarySG: UISegmentedControl!
    @IBOutlet weak var itemCostLabel: UILabel!
    
    
    
    var selectedSection = 0
    var indexPath = 0
    
    lazy var subGroup = NewStorage.shared.storageGroups[selectedSection].subGroups[indexPath]
    var currentItem : JSONItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageSubGroup.image = UIImage(named: subGroup.image)
        titleSubGroup.text = subGroup.title
        

        
        if (subGroup.subGroups[0].subGroups.count > 0) {
            setupDouble()
            
        } else{
            setupSingle()
            
        }
        mainSG.addTarget(self, action: #selector(setCurrentItem), for: .valueChanged)
        secondarySG.addTarget(self, action: #selector(setCurrentItem), for: .valueChanged)
        refreshCost()
        
    }
    func refreshCost(){
        if (subGroup.subGroups[0].subGroups.count > 0) {
            self.currentItem = NewStorage.shared.storageGroups[selectedSection].subGroups[indexPath].subGroups.first?.subGroups[mainSG.selectedSegmentIndex].subGroups.first?.items[secondarySG.selectedSegmentIndex] ?? JSONItem(title: "", price: 0)
//            self.currentItem = subGroup.subGroups.first?.subGroups[mainSG.selectedSegmentIndex].subGroups.first?.items[secondarySG.selectedSegmentIndex] ?? JSONItem(title: "", price: 0)
            
            
        } else{
            self.currentItem = NewStorage.shared.storageGroups[selectedSection].subGroups[indexPath].subGroups.first?.items[mainSG.selectedSegmentIndex] ?? JSONItem(title: "", price: 0)
//            self.currentItem = subGroup.subGroups.first?.items[mainSG.selectedSegmentIndex] ?? JSONItem(title: "", price: 0)
            
        }
        itemCostLabel.text = "Selected item cost : \(currentItem.price)"
    }
    
    func setupSingle(){
        titleSecondarySubGroup.isHidden = true
        secondarySG.isHidden = true
        titleMainSubGroup.text = subGroup.subGroups.first?.title ?? ""
        itemCostLabel.text = subGroup.subGroups.first?.items[mainSG.selectedSegmentIndex].title
        mainSG.removeAllSegments()
        for (index, _) in subGroup.subGroups[0].items.enumerated(){
            mainSG.insertSegment(withTitle: subGroup.subGroups[0].items[index].title, at: index, animated: false)
        }
        mainSG.selectedSegmentIndex = 0
    }
    func setupDouble(){
        titleMainSubGroup.text = subGroup.subGroups.first?.title ?? ""
        itemCostLabel.text = subGroup.subGroups.first?.subGroups[mainSG.selectedSegmentIndex].subGroups.first?.items[secondarySG.selectedSegmentIndex].title
        mainSG.removeAllSegments()
        for (index, _) in subGroup.subGroups[0].subGroups.enumerated(){
            mainSG.insertSegment(withTitle: subGroup.subGroups[0].subGroups[index].title, at: index, animated: false)
        }
        mainSG.selectedSegmentIndex = 0
        titleSecondarySubGroup.text = subGroup.subGroups[0].subGroups[0].subGroups[0].title
        secondarySG.removeAllSegments()
        
        
        for (index, _) in subGroup.subGroups[0].subGroups[0].subGroups[0].items.enumerated(){
            secondarySG.insertSegment(withTitle: subGroup.subGroups[0].subGroups[0].subGroups[0].items[index].title, at: index, animated: false)
        }
        secondarySG.selectedSegmentIndex = 0
        
    }
    @objc func setCurrentItem(sender: UISegmentedControl){
        
        if (subGroup.subGroups[0].subGroups.count > 0) {
            self.currentItem = subGroup.subGroups.first?.subGroups[mainSG.selectedSegmentIndex].subGroups.first?.items[secondarySG.selectedSegmentIndex] ?? JSONItem(title: "", price: 0)
            refreshCost()
            
        } else{
            self.currentItem = subGroup.subGroups.first?.items[mainSG.selectedSegmentIndex] ?? JSONItem(title: "", price: 0)
            refreshCost()
        }
    }
    
    @IBAction func changeItemCost(_ sender: Any) {
        let alert = UIAlertController(title: "Item cost", message: "Change item cost?", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "\(self.currentItem.price)"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: { [self, weak alert] (_)  in
            let textField = alert?.textFields![0].text ?? "0"
            if let cost = Int(textField){
                currentItem.price = cost
                refreshCost()
                if (subGroup.subGroups[0].subGroups.count > 0) {
                    //double
                    NewStorage.shared.storageGroups[selectedSection].subGroups[indexPath].subGroups[0].subGroups[mainSG.selectedSegmentIndex].subGroups[0].items[secondarySG.selectedSegmentIndex].price = cost
                    refreshCost()
                } else{
                    //single
                    NewStorage.shared.storageGroups[selectedSection].subGroups[indexPath].subGroups[0].items[mainSG.selectedSegmentIndex].price = cost
                    refreshCost()
                }
            } else {
                let errorAlert = UIAlertController(title: "Invalid cost", message: "Input valid cost", preferredStyle: .alert)
                errorAlert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(errorAlert, animated: true)
            }
            
            
        }))
            
        self.present(alert, animated: true)
    }
    

}
