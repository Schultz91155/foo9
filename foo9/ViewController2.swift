////
////  ViewController2.swift
////  foo9
////
////  Created by Pavel Brovkin on 02.03.2024.
////
//
//import UIKit
//
//class ViewController2: UIViewController {
//
//    
//
//    @IBOutlet weak var collectionView: UICollectionView!
//    let storage = Storage()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(UINib(nibName: "CollectionViewCell2", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell2")
////
//    }
//    
//
//
//
//}
//extension ViewController2: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return storage.parsedGroups[0].groups?.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell2", for: indexPath) as! CollectionViewCell2
//        cell.setupCell(group: (storage.parsedGroups[0].groups?[indexPath.row])!)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.frame.width - 10, height: 30)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        10
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        10
//    }
//}
