//
//  PresetViewController.swift
//  foo9
//
//  Created by Pavel Brovkin on 11.03.2024.
//

import UIKit

class PresetViewController: UIViewController {
    
    private var longTapGesture : UILongPressGestureRecognizer!
    
    @IBOutlet weak var presetsCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presetsCollectionView.dataSource = self
        presetsCollectionView.delegate = self
        presetsCollectionView.register(UINib(nibName: "PresetCell", bundle: nil), forCellWithReuseIdentifier: "PresetCell")
        load()
        setupLongTapGesture()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.presetsCollectionView.reloadData()
    }
    
    @IBAction func createPreset(_ sender: Any) {
        let presetBuilderVC = storyboard?.instantiateViewController(identifier: "PresetBuilderVC") as! PresetBuilderViewController
        self.present(presetBuilderVC, animated: true)
    }
    
    func setupLongTapGesture(){
        longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongTap))
        presetsCollectionView.addGestureRecognizer(longTapGesture)
        longTapGesture.delaysTouchesBegan = true
    }
    
    @objc func didLongTap(){
        let pointInPresetsCollection = longTapGesture.location(in: presetsCollectionView)
        if let indexPath = presetsCollectionView.indexPathForItem(at: pointInPresetsCollection){
            let alert = UIAlertController(title: "Delete?", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
            alert.addAction(cancelAction)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alert] (_) in
                PresetsStorage.shared.presets.remove(at: indexPath.row)
                presetsCollectionView.reloadData()
                
            }))
            self.present(alert , animated: true)

        }
        
    }

    

}

extension PresetViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        PresetsStorage.shared.presets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = presetsCollectionView.dequeueReusableCell(withReuseIdentifier: "PresetCell", for: indexPath) as! PresetCell
        cell.setupCell(preset: PresetsStorage.shared.presets[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: presetsCollectionView.bounds.width / 2 - 10, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentPreset = PresetsStorage.shared.presets[indexPath.row]
        switch(currentPreset.type){
            
        case .single:
            let presetSingleEditorVC = storyboard?.instantiateViewController(identifier: "PresetSingleEditorVC") as! PresetEditorSingleViewController
            presetSingleEditorVC.indexPath = indexPath.row
            self.present(presetSingleEditorVC, animated: true)
        case .double:
            print("foo")
        }
    }
    
}

extension PresetViewController {
    func load() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "presets") as? Data{
            do{
                let decodedData = try JSONDecoder().decode([Preset].self, from: savedData)
                PresetsStorage.shared.presets = decodedData
            
            } catch{
                print("Error : \(String(describing: error))")
            }
        }

    }
}
