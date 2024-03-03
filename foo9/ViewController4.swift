//
//  ViewController4.swift
//  foo9
//
//  Created by Pavel Brovkin on 02.03.2024.
//

import UIKit

class ViewController4: UIViewController {

    @IBOutlet weak var gropsCollectionView: UICollectionView!
    
    @IBOutlet weak var createGroupOutlet: UIButton!
    
    var storageGroups  = [JSONGroups]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDoubleTap()
//        createGroupOutlet.isEnabled = false
//        createGroupOutlet.alpha = 0.5
        gropsCollectionView.dataSource = self
        gropsCollectionView.delegate = self
        gropsCollectionView.register(UINib(nibName: "CollectionViewCell3", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell3")
        // Do any additional setup after loading the view.
        
  
        

        
    }
    

    @IBAction func createGroup(_ sender: Any) {
        
        
        
        let alarm = UIAlertController(title: "Create new group", message: nil, preferredStyle: .alert)
        alarm.addTextField { (textField) in
            textField.placeholder = "Enter First Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alarm.addAction(cancelAction)
        alarm.addAction(UIAlertAction(title: "Create", style: .default, handler: { [self, weak alarm] (_) in
            let textField = alarm?.textFields![0].text ?? "New group" // Force unwrapping because we know it exists.
            
            let isContain = storageGroups.contains { groups in
                groups.self.title == textField
            }
            if (!isContain){
                let newGroup = JSONGroups(title: textField, groups: [JSONGroups](), subGroups: [JSONSubGroup]())
                self.storageGroups.append(newGroup)
                self.gropsCollectionView.reloadData()
            }

            
            

        }))


        self.present(alarm, animated: true)
    }
    private var doubleTapGesture: UITapGestureRecognizer!
      func setUpDoubleTap() {
          doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapCollectionView))
          doubleTapGesture.numberOfTapsRequired = 2
          gropsCollectionView.addGestureRecognizer(doubleTapGesture)
          doubleTapGesture.delaysTouchesBegan = true
      }
    
    @objc func didDoubleTapCollectionView() {
           let pointInCollectionView = doubleTapGesture.location(in: gropsCollectionView)
           if let selectedIndexPath = gropsCollectionView.indexPathForItem(at: pointInCollectionView) {
               let selectedCell = gropsCollectionView.cellForItem(at: selectedIndexPath)
               // Print double tapped cell's path
               self.storageGroups.remove(at: selectedIndexPath.row)
               self.gropsCollectionView.reloadData()

           }
       }
    

}

extension ViewController4 : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storageGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = gropsCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell3", for: indexPath) as! CollectionViewCell3
        cell.setupCell(group: storageGroups[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let groupName = storageGroups[indexPath.row].title
        let width = groupName.widthOfString(usingFont: UIFont.systemFont(ofSize: 20)) + 10
        return CGSize(width: width, height: gropsCollectionView.bounds.height)

        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }

}




