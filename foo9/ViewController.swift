//
//  ViewController.swift
//  foo9
//
//  Created by Pavel Brovkin on 17.02.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var groupColectionView: UICollectionView!
    
    let storage = Storage()
    var selectedSection = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.groupColectionView.register(UINib(nibName: "GroupCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GroupCollectionViewCell")
        self.groupColectionView.dataSource = self
        self.groupColectionView.delegate = self
        
//        let jsonData = try! JSONEncoder().encode(storage.groups[0].groups)
//        let jsonString = String(data: jsonData, encoding: .utf8)
//        print(jsonString)
  
        // Do any additional setup after loading the view.
    }

    
}
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == self.collectionView){
            return storage.groups[selectedSection].groups!.count
        } else{
            return storage.groups.count
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.collectionView){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.setupCell(group: storage.groups[selectedSection].groups![indexPath.row])
            return cell
            
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCollectionViewCell", for: indexPath) as! GroupCollectionViewCell
            cell.setupCell(group: storage.groups[indexPath.row])
            return cell
        }
        
 
        
            

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (collectionView == self.collectionView){
            return CGSize(width: self.view.frame.width - 10, height: 80)
        } else{
            let groupName = storage.groups[indexPath.row].name
            let width = groupName.widthOfString(usingFont: UIFont.systemFont(ofSize: 20)) + 10
            return CGSize(width: width, height: groupColectionView.bounds.height)

        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
  
        if (collectionView == self.collectionView){
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let currentGroup = storage.groups[selectedSection].groups![indexPath.row]
            switch (currentGroup.type){
            case .pizza :
                let fullVC = storyboard.instantiateViewController(identifier: "fullVC") as! FullViewController
                fullVC.group = currentGroup
                self.present(fullVC, animated: true)
            case .burger :
                let full2VC = storyboard.instantiateViewController(identifier: "full2VC") as! Full2ViewController
                //full2VC.group = currentContainer as! Group
                self.present(full2VC, animated: true)
            
            }
            
        } else{
            selectedSection = indexPath.row
            self.collectionView.reloadData()
            
        }
        




    }
    
    
}

