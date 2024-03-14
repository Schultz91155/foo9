//
//  PresetBuilderViewController.swift
//  foo9
//
//  Created by Pavel Brovkin on 11.03.2024.
//

import UIKit

class PresetBuilderViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var mainSubGroupTitle: UITextField!
    
    @IBOutlet weak var mainSubGroupItems: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainSubGroupTitle.delegate = self
        
        saveButtonOutlet.isEnabled = false
        saveButtonOutlet.alpha = 0.5
        mainSubGroupTitle.isHidden = true
        mainSubGroupItems.isHidden = true
        self.titleTextField.addTarget(self, action: #selector(isTextFiledEmpty(sender:)), for: UIControl.Event.editingChanged)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let presetTitle = titleTextField.text ?? "New preset"
        let presetMainSubgroupTitle = mainSubGroupTitle.text ?? "new main subgroup title"
        let mainSubGroupItemsString = mainSubGroupItems.text ?? ""
        let mainSubGroupItems = mainSubGroupItemsString.split(separator: " ").map(String.init)
        
        PresetsStorage.shared.presets.append(Preset(title: presetTitle, mainSubGroupTitle: presetMainSubgroupTitle, mainSubGroupItems: mainSubGroupItems, type: .single))

        if let presetViewController = self.presentingViewController as? PresetViewController {
                self.dismiss(animated: true) {
                    presetViewController.presetsCollectionView.reloadData()
                }
            }
    }
    
    
    @objc func isTextFiledEmpty(sender : UITextView){
        if sender.text.isEmpty{
            saveButtonOutlet.isEnabled = false
            saveButtonOutlet.alpha = 0.5
            mainSubGroupTitle.isHidden = true
            mainSubGroupItems.isHidden = true
        }else{
            let presetTitle = titleTextField.text ?? "New preset"
            let isContain = PresetsStorage.shared.presets.contains { presetTitles in
                presetTitles.self.title == presetTitle
            }
            if (!isContain){
                saveButtonOutlet.isEnabled = true
                saveButtonOutlet.alpha = 1
                mainSubGroupTitle.isHidden = false
                
            }else{
                saveButtonOutlet.isEnabled = false
                saveButtonOutlet.alpha = 0.5
                mainSubGroupTitle.isHidden = true
                mainSubGroupItems.isHidden = true
            }

        }
    }
}

extension PresetBuilderViewController : UITextFieldDelegate{
    

    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let presetMainSubgroupTitle = mainSubGroupTitle.text ?? "new main subgroup title"
        if (presetMainSubgroupTitle.isEmpty){
            mainSubGroupItems.isHidden = true
        } else{
            mainSubGroupItems.isHidden = false
        }
    }
}

