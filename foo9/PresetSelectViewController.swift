//
//  SelectViewController.swift
//  foo9
//
//  Created by Pavel Brovkin on 17.03.2024.
//

import UIKit

class PresetSelectViewController: UIViewController {

    @IBOutlet weak var presetsTableView: UITableView!
    
    var selectedSection = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presetsTableView.delegate = self
        presetsTableView.dataSource = self
        presetsTableView.register(UINib(nibName: "SelectPresetCell", bundle: nil), forCellReuseIdentifier: "SelectPresetCell")
    }
    



}

extension PresetSelectViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(PresetsStorage.shared.presets.count)
        return PresetsStorage.shared.presets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = presetsTableView.dequeueReusableCell(withIdentifier: "SelectPresetCell") as! SelectPresetCell
        cell.setupCell(preset: PresetsStorage.shared.presets[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presetsTableView.deselectRow(at: indexPath, animated: true)
        
        switch (PresetsStorage.shared.presets[indexPath.row].type){
        
        case .none:
            var itemArray = [JSONItem]()
            let item = JSONItem(title: PresetsStorage.shared.presets[indexPath.row].title, price: 0)
            itemArray.append(item)
            let newSubGroup = JSONSubGroup(title: "empty", image: "pizza", subGroups: [JSONSubGroup](), items: itemArray)
            NewStorage.shared.storageGroups[selectedSection].subGroups.append(newSubGroup)
            
            if let presentingViewController = self.presentingViewController as? GroupsViewController {
                    self.dismiss(animated: true) {
                        presentingViewController.subGroupsCollectionView.reloadData()
                    }
                }
        case .single:
            
            var itemArray = [JSONItem]()
            for item in PresetsStorage.shared.presets[indexPath.row].mainSubGroupItems!{
                itemArray.append(JSONItem(title: item, price: 0))

            }
            let mainSubGroup = JSONSubGroup(title: PresetsStorage.shared.presets[indexPath.row].mainSubGroupTitle!, image: "pizza", subGroups: [JSONSubGroup](), items: itemArray)
            let newSubGroup = JSONSubGroup(title: "empty", image: "pizza",  subGroups: [mainSubGroup], items: [JSONItem]())
            NewStorage.shared.storageGroups[selectedSection].subGroups.append(newSubGroup)
            
            if let presentingViewController = self.presentingViewController as? GroupsViewController {
                    self.dismiss(animated: true) {
                        presentingViewController.subGroupsCollectionView.reloadData()
                    }
                }
            
        case .double:

            var secondaryItemArray = [JSONItem]()
            
            for item in PresetsStorage.shared.presets[indexPath.row].secondarySubGroupItems!{
                let currentJSONItem = JSONItem(title: item, price: 0)
                secondaryItemArray.append(currentJSONItem) // traditional , slim
            }
            let secondarySubGroup = JSONSubGroup(title: PresetsStorage.shared.presets[indexPath.row].secondarySubGroupTitle!, image: "pizza", subGroups: [JSONSubGroup](), items: secondaryItemArray)
            
            var mainSubGroupsArray = [JSONSubGroup]()
            for (index, _) in PresetsStorage.shared.presets[indexPath.row].mainSubGroupItems!.enumerated(){
                let currentSubGroup = JSONSubGroup(title: PresetsStorage.shared.presets[indexPath.row].mainSubGroupItems![index], image: "pizza", subGroups: [secondarySubGroup], items: [JSONItem]())
                mainSubGroupsArray.append(currentSubGroup)
            }
            
            let mainSubGroup = JSONSubGroup(title: PresetsStorage.shared.presets[indexPath.row].mainSubGroupTitle!, image: "pizza", subGroups: mainSubGroupsArray, items: [JSONItem]())
            
            let newSubGroup = JSONSubGroup(title: "empty", image: "pizza",  subGroups: [mainSubGroup], items: [JSONItem]())
            
            
            
            
            NewStorage.shared.storageGroups[selectedSection].subGroups.append(newSubGroup)
            if let presentingViewController = self.presentingViewController as? GroupsViewController {
                    self.dismiss(animated: true) {
                        presentingViewController.subGroupsCollectionView.reloadData()
                    }
                }
                
        }
        
    }
}
