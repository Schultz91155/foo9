//
//  GroupsViewController.swift
//  foo9
//
//  Created by Pavel Brovkin on 02.03.2024.
//

import UIKit

class GroupsViewController: UIViewController {

    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet weak var subGroupsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var createGroupOutlet: UIButton!
    
    
    private var doubleTapGroupCollectionViwGesture: UITapGestureRecognizer!
    private var doubleTapSubGroupCollectionViwGesture: UITapGestureRecognizer!
    
    private var longPressGestureGroupsCollectionView: UILongPressGestureRecognizer!
    private var longPressGestureSubGroupsCollectionView: UILongPressGestureRecognizer!

    var selectedSection = 0
    
    

    
    
//    var storageGroups  = NewStorage.shared.storageGroups

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        
        setUpDoubleTapGroupCollectionView()
        setUpDoubleTapSubGroupCollectionView()
        setupLongPressGroupsCollectionView()
        setupLongPressSubGroupsCollectionView()
        groupsCollectionView.dataSource = self
        groupsCollectionView.delegate = self
        groupsCollectionView.register(UINib(nibName: "GroupCell", bundle: nil), forCellWithReuseIdentifier: "GroupCell")
        subGroupsCollectionView.dataSource = self
        subGroupsCollectionView.delegate = self
        subGroupsCollectionView.register(UINib(nibName: "SubGroupCell", bundle: nil), forCellWithReuseIdentifier: "SubGroupCell")
        
        
    }
    


    @IBAction func createGroup(_ sender: Any) {
        let alarm = UIAlertController(title: "Create new group", message: nil, preferredStyle: .alert)
        alarm.addTextField { (textField) in
            textField.placeholder = "Enter group Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alarm.addAction(cancelAction)
        alarm.addAction(UIAlertAction(title: "Create", style: .default, handler: { [self, weak alarm] (_) in
            let textField = alarm?.textFields![0].text ?? "New group" // Force unwrapping because we know it exists.
            
            let isContain = NewStorage.shared.storageGroups.contains { groups in
                groups.self.title == textField
            }
            if (!isContain){
                let newGroup = JSONGroups(title: textField, subGroups: [JSONSubGroup]())
                NewStorage.shared.storageGroups.append(newGroup)
                self.groupsCollectionView.reloadData()
                
            }
        }))
        self.present(alarm, animated: true)
        
    }
    
    
    @IBAction func createSubGroup(_ sender: Any) {

//        let newSubGroup = JSONSubGroup(title: "empty", image: "pizza",  subGroups: [JSONSubGroup](), items: [JSONItem]())
//        NewStorage.shared.storageGroups[selectedSection].subGroups.append(newSubGroup)
//        self.subGroupsCollectionView.reloadData()
        
        let selectPresetVC = storyboard?.instantiateViewController(identifier: "SelectPresetVC") as! PresetSelectViewController
        selectPresetVC.selectedSection = self.selectedSection
        self.present(selectPresetVC, animated: true)
    }
    
    @IBAction func createPreset(_ sender: Any) {
        let presetVC = storyboard?.instantiateViewController(identifier: "PresetVC") as! PresetViewController
        self.present(presetVC, animated: true)
    }
    
    
    
      func setUpDoubleTapGroupCollectionView() {
          doubleTapGroupCollectionViwGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapGroupCollectionView))
          doubleTapGroupCollectionViwGesture.numberOfTapsRequired = 2
          groupsCollectionView.addGestureRecognizer(doubleTapGroupCollectionViwGesture)
          doubleTapGroupCollectionViwGesture.delaysTouchesBegan = true
      }
    
    @objc func didDoubleTapGroupCollectionView() {
           let pointInCollectionView = doubleTapGroupCollectionViwGesture.location(in: groupsCollectionView)
           if let selectedIndexPath = groupsCollectionView.indexPathForItem(at: pointInCollectionView) {
               
               let alarm = UIAlertController(title: "Input new title", message: nil, preferredStyle: .alert)
               alarm.addTextField { (textField) in
                   textField.text = NewStorage.shared.storageGroups[selectedIndexPath.row].title
               }
               
               let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
               alarm.addAction(cancelAction)
               alarm.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [self, weak alarm] (_) in
                   let textField = alarm?.textFields![0].text ?? "New group" // Force unwrapping because we know it exists.
                   NewStorage.shared.storageGroups[selectedIndexPath.row].title = textField
                   self.groupsCollectionView.reloadItems(at: [selectedIndexPath])
               }))
               self.present(alarm, animated: true)

           }
       }

    func setUpDoubleTapSubGroupCollectionView() {
        doubleTapSubGroupCollectionViwGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapSubGroupCollectionView))
        doubleTapSubGroupCollectionViwGesture.numberOfTapsRequired = 2
        subGroupsCollectionView.addGestureRecognizer(doubleTapSubGroupCollectionViwGesture)
        doubleTapSubGroupCollectionViwGesture.delaysTouchesBegan = true
    }

    @objc func didDoubleTapSubGroupCollectionView() {
        let pointInCollectionView = doubleTapSubGroupCollectionViwGesture.location(in: subGroupsCollectionView)
        if let selectedIndexPath = subGroupsCollectionView.indexPathForItem(at: pointInCollectionView) {
            let selectedCell = subGroupsCollectionView.cellForItem(at: selectedIndexPath) as! SubGroupCell
            let pointInCollectionViewCell = doubleTapSubGroupCollectionViwGesture.location(in: selectedCell)
            
            if selectedCell.titleSubGroup.bounds.contains(pointInCollectionViewCell){
                selectedCell.titleSubGroup.isUserInteractionEnabled = true
                selectedCell.editBtnOutlet.isHidden = false
                
                let currentSubGroup = NewStorage.shared.storageGroups[selectedSection].subGroups[selectedIndexPath.row]
                selectedCell.subGroup = currentSubGroup
                selectedCell.currentIndexPath = selectedIndexPath
                selectedCell.currentSection = selectedSection

                
            }
            else if selectedCell.imageSubGroup.bounds.contains(pointInCollectionViewCell){
                //                 selectedCell.imageSubGroup.image = UIImage(named: "meatPizza")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let galleryVC = storyboard.instantiateViewController(identifier: "galleryVC") as! GalleryViewController
                self.present(galleryVC, animated: true)
                
                galleryVC.complition2 = { [weak self] image in
                    guard let self = self else {return}
                    selectedCell.imageSubGroup.image = UIImage(named: image)
                    NewStorage.shared.storageGroups[selectedSection].subGroups[selectedIndexPath.row].image = image
                }
                
            }
        }
    }
        func setupLongPressGroupsCollectionView(){
            longPressGestureGroupsCollectionView = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressGropsCollectionView))
            groupsCollectionView.addGestureRecognizer(longPressGestureGroupsCollectionView)
            longPressGestureGroupsCollectionView.delaysTouchesBegan = true
        }
    
        @objc func didLongPressGropsCollectionView() {
            let pointInCollectionView = longPressGestureGroupsCollectionView.location(in: groupsCollectionView)
            if let selectedIndexPath = groupsCollectionView.indexPathForItem(at: pointInCollectionView) {
                let selectedCell = groupsCollectionView.cellForItem(at: selectedIndexPath)
                let alarm = UIAlertController(title: "Delete?", message: nil, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
                alarm.addAction(cancelAction)
                alarm.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alarm] (_) in
                    NewStorage.shared.storageGroups.remove(at: selectedIndexPath.row)
                    self.groupsCollectionView.reloadData()
                    self.subGroupsCollectionView.reloadData()
                    
                }))
                self.present(alarm, animated: true)
                
            }
        }
    
    func setupLongPressSubGroupsCollectionView(){
        longPressGestureSubGroupsCollectionView = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressSubGropsCollectionView))
        subGroupsCollectionView.addGestureRecognizer(longPressGestureSubGroupsCollectionView)
        longPressGestureSubGroupsCollectionView.delaysTouchesBegan = true
    }

    @objc func didLongPressSubGropsCollectionView() {
        let pointInCollectionView = longPressGestureSubGroupsCollectionView.location(in: subGroupsCollectionView)
        if let selectedIndexPath = subGroupsCollectionView.indexPathForItem(at: pointInCollectionView) {
            let selectedCell = subGroupsCollectionView.cellForItem(at: selectedIndexPath)
            let alarm = UIAlertController(title: "Delete?", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            alarm.addAction(cancelAction)
            alarm.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alarm] (_) in
                NewStorage.shared.storageGroups[selectedSection].subGroups.remove(at: selectedIndexPath.row)
                self.subGroupsCollectionView.reloadData()
                
            }))
            self.present(alarm, animated: true)
            
        }
    }
}

extension GroupsViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == groupsCollectionView){
            return NewStorage.shared.storageGroups.count
        } else{
            if (NewStorage.shared.storageGroups.isEmpty) {
                return 0 }
            else{
                   return NewStorage.shared.storageGroups[selectedSection].subGroups.count
                }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == groupsCollectionView){
            let cell = groupsCollectionView.dequeueReusableCell(withReuseIdentifier: "GroupCell", for: indexPath) as! GroupCell
            cell.setupCell(group: NewStorage.shared.storageGroups[indexPath.row])
            return cell
        }else{
            let cell = subGroupsCollectionView.dequeueReusableCell(withReuseIdentifier: "SubGroupCell", for: indexPath) as! SubGroupCell
            cell.setupCell(subGroup: NewStorage.shared.storageGroups[selectedSection].subGroups[indexPath.row])
            return cell
            
        }
        
        

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if (collectionView == groupsCollectionView){
            let groupName = NewStorage.shared.storageGroups[indexPath.row].title
            let width = groupName.widthOfString(usingFont: UIFont.systemFont(ofSize: 20)) + 10
            return CGSize(width: width, height: groupsCollectionView.bounds.height)
        } else{
            return CGSize(width: subGroupsCollectionView.bounds.width - 20, height: 120)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        
        if (collectionView == groupsCollectionView){
           return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        } else{
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if (collectionView == groupsCollectionView){
           return 10
        } else{
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if (collectionView == groupsCollectionView){
           return 10
        } else{
            return 10
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == groupsCollectionView){
            selectedSection = indexPath.row
            subGroupsCollectionView.reloadData()
        } else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let itemVC = storyboard.instantiateViewController(identifier: "itemVC") as! ItemViewController
            itemVC.selectedSection = selectedSection
            itemVC.indexPath = indexPath.row
            self.present(itemVC, animated: true)
        }
    }

}
extension GroupsViewController {
    func load() {
        let defaults = UserDefaults.standard
        if let savedJSONGroups = defaults.object(forKey: "key") as? Data{
            do{
                //                let jsonString = String(data: savedData, encoding: .utf8)
                //                print(jsonString!)
                let decodedData = try JSONDecoder().decode([JSONGroups].self, from: savedJSONGroups)
                NewStorage.shared.storageGroups = decodedData
                
            } catch{
                print ("Can't load saved JSONGroups")
            }
            
        }
        if let savedPresets = defaults.object(forKey: "presets") as? Data{
            do{
                let decodedData = try JSONDecoder().decode([Preset].self, from: savedPresets)
                PresetsStorage.shared.presets = decodedData
            
            } catch{
                print("Error : \(String(describing: error))")
            }
        }
    }
}



