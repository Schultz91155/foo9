//
//  ViewController4.swift
//  foo9
//
//  Created by Pavel Brovkin on 02.03.2024.
//

import UIKit

class ViewController4: UIViewController {

    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet weak var subGroupsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var createGroupOutlet: UIButton!
    
    
    private var doubleTapGesture: UITapGestureRecognizer!
    private var longPressGesture: UILongPressGestureRecognizer!
    let key = "storage"
    var selectedSection = 0
    
    var storageGroups  = [JSONGroups]()
    {
        didSet{
            save(storage: self.storageGroups)
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        setUpDoubleTapGroupCollectionView()
        setUpDoubleTapSubGroupCollectionView()
        setupLongPress()
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
            
            let isContain = storageGroups.contains { groups in
                groups.self.title == textField
            }
            if (!isContain){
                let newGroup = JSONGroups(title: textField, subGroups: [JSONSubGroup]())
                self.storageGroups.append(newGroup)
                self.groupsCollectionView.reloadData()
                save(storage: self.storageGroups)
            }
        }))
        self.present(alarm, animated: true)
    }
    
    
    @IBAction func createSubGroup(_ sender: Any) {

        let newSubGroup = JSONSubGroup(title: "empty", image: "pizza",  subGroups: [JSONSubGroup](), items: [JSONItem]())
        self.storageGroups[selectedSection].subGroups.append(newSubGroup)
        self.subGroupsCollectionView.reloadData()

    }
    
    
      func setUpDoubleTapGroupCollectionView() {
          doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapGroupCollectionView))
          doubleTapGesture.numberOfTapsRequired = 2
          groupsCollectionView.addGestureRecognizer(doubleTapGesture)
          doubleTapGesture.delaysTouchesBegan = true
      }
    
    @objc func didDoubleTapGroupCollectionView() {
           let pointInCollectionView = doubleTapGesture.location(in: groupsCollectionView)
           if let selectedIndexPath = groupsCollectionView.indexPathForItem(at: pointInCollectionView) {
               let selectedCell = groupsCollectionView.cellForItem(at: selectedIndexPath)
               
               let alarm = UIAlertController(title: "Input new title", message: nil, preferredStyle: .alert)
               alarm.addTextField { (textField) in
                   textField.text = self.storageGroups[selectedIndexPath.row].title
               }
               
               let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
               alarm.addAction(cancelAction)
               alarm.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [self, weak alarm] (_) in
                   let textField = alarm?.textFields![0].text ?? "New group" // Force unwrapping because we know it exists.
                   self.storageGroups[selectedIndexPath.row].title = textField
                   self.groupsCollectionView.reloadItems(at: [selectedIndexPath])
               }))
               self.present(alarm, animated: true)

           }
       }
    
    func setUpDoubleTapSubGroupCollectionView() {
        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapSubGroupCollectionView))
        doubleTapGesture.numberOfTapsRequired = 2
        subGroupsCollectionView.addGestureRecognizer(doubleTapGesture)
        doubleTapGesture.delaysTouchesBegan = true
    }

  @objc func didDoubleTapSubGroupCollectionView() {
         let pointInCollectionView = doubleTapGesture.location(in: subGroupsCollectionView)

         if let selectedIndexPath = subGroupsCollectionView.indexPathForItem(at: pointInCollectionView) {
             let selectedCell = subGroupsCollectionView.cellForItem(at: selectedIndexPath) as!SubGroupCell
             let pointInCollectionViewCell = doubleTapGesture.location(in: selectedCell)
             
             if selectedCell.titleSubGroup.bounds.contains(pointInCollectionViewCell){
                 selectedCell.titleSubGroup.isUserInteractionEnabled = true
                 selectedCell.editBtnOutlet.isHidden = false
                 // TODO : pass data to SubGroupCell; end editing and save changes in subgroup by press End editing
                 // TODO : createLongPressgesture by remove subgroup
                 // TODO : reload subGroupsCollectionView by scroll groupsCollectionView
                 
                 
                 
                 
                 
             }
             else if selectedCell.imageSubGroup.bounds.contains(pointInCollectionViewCell){
                 print("image in \(selectedIndexPath)")
             }

         }
     }
        func setupLongPress(){
            longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
            groupsCollectionView.addGestureRecognizer(longPressGesture)
            longPressGesture.delaysTouchesBegan = true
        }
    
        @objc func didLongPress() {
            let pointInCollectionView = longPressGesture.location(in: groupsCollectionView)
            if let selectedIndexPath = groupsCollectionView.indexPathForItem(at: pointInCollectionView) {
                let selectedCell = groupsCollectionView.cellForItem(at: selectedIndexPath)
                let alarm = UIAlertController(title: "Delete?", message: nil, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
                alarm.addAction(cancelAction)
                alarm.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alarm] (_) in
                    self.storageGroups.remove(at: selectedIndexPath.row)
                    self.groupsCollectionView.reloadData()
                    self.subGroupsCollectionView.reloadData()
                    save(storage: self.storageGroups)
                }))
                self.present(alarm, animated: true)
                
            }
        }
}

extension ViewController4 : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == groupsCollectionView){
            return storageGroups.count
        } else{
            if (storageGroups.isEmpty) {
                return 0 }
            else{
                   return storageGroups[selectedSection].subGroups.count
                }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == groupsCollectionView){
            let cell = groupsCollectionView.dequeueReusableCell(withReuseIdentifier: "GroupCell", for: indexPath) as! GroupCell
            cell.setupCell(group: storageGroups[indexPath.row])
            return cell
        }else{
            let cell = subGroupsCollectionView.dequeueReusableCell(withReuseIdentifier: "SubGroupCell", for: indexPath) as! SubGroupCell
            cell.setupCell(subGroup: storageGroups[selectedSection].subGroups[indexPath.row])
            return cell
            
        }
        
        

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if (collectionView == groupsCollectionView){
            let groupName = storageGroups[indexPath.row].title
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

    }

}
extension ViewController4 {
    
    
    func save(storage : [JSONGroups]){
        do{
            let encodedData = try JSONEncoder().encode(storage)
            let defaults = UserDefaults.standard
            defaults.set(encodedData, forKey: key)
        } catch{
            print ("Can't save")
        }
    }
    
    func load() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: key) as? Data{
            do{
                let jsonString = String(data: savedData, encoding: .utf8)
                print(jsonString!)
                let decodedData = try JSONDecoder().decode([JSONGroups].self, from: savedData)
                storageGroups = decodedData
            
            } catch{
                print ("Can't load")
            }
        }

    }
}



