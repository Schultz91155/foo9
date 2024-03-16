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
        print (indexPath.row)
        presetsTableView.deselectRow(at: indexPath, animated: true)
        
        switch (PresetsStorage.shared.presets[indexPath.row].type){
            
        case .single:
            
            var itemArray = [JSONItem]()
            for item in PresetsStorage.shared.presets[indexPath.row].mainSubGroupItems{
                
                let currentJSONItem = JSONItem(title: item, price: 0)
                itemArray.append(JSONItem(title: item, price: 0))

            }
            let mainSubGroup = JSONSubGroup(title: PresetsStorage.shared.presets[indexPath.row].mainSubGroupTitle, image: "pizza", subGroups: [JSONSubGroup](), items: itemArray)
            let newSubGroup = JSONSubGroup(title: "empty", image: "pizza",  subGroups: [mainSubGroup], items: [JSONItem]())
            NewStorage.shared.storageGroups[selectedSection].subGroups.append(newSubGroup)
            
            if let presentingViewController = self.presentingViewController as? ViewController4 {
                    self.dismiss(animated: true) {
                        presentingViewController.subGroupsCollectionView.reloadData()
                    }
                }
            
            
            
            
        case .double:
            print( "foo")
        }
        
        //        let newSubGroup = JSONSubGroup(title: "empty", image: "pizza",  subGroups: [JSONSubGroup](), items: [JSONItem]())
        //        NewStorage.shared.storageGroups[selectedSection].subGroups.append(newSubGroup)
        //        self.subGroupsCollectionView.reloadData()
        
        
    }
}
