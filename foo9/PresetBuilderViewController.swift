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
    
    @IBOutlet weak var secondarySubGroupTitle: UITextField!
    
    @IBOutlet weak var secondarySubGroupItems: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButtonOutlet.isEnabled = false
        saveButtonOutlet.alpha = 0.5
        
        mainSubGroupTitle.isHidden = true
        mainSubGroupItems.isHidden = true
        secondarySubGroupTitle.isHidden = true
        secondarySubGroupItems.isHidden = true
        
        self.titleTextField.addTarget(self, action: #selector(showMainSubgroupTitile(sender:)), for: UIControl.Event.editingChanged)
        self.mainSubGroupTitle.addTarget(self, action: #selector(showMainSubGroupItems(sender:)), for: UIControl.Event.editingChanged)
        self.mainSubGroupItems.addTarget(self, action: #selector(showSecondarySubgroupTitile(sender:)), for: UIControl.Event.editingChanged)
        self.secondarySubGroupTitle.addTarget(self, action: #selector(showSeconadarySubGroupItems(sender:)), for: UIControl.Event.editingChanged)
        self.secondarySubGroupItems.addTarget(self, action: #selector(showSvaeButton(sender:)), for: UIControl.Event.editingChanged)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let presetTitle = titleTextField.text ?? "New preset"
        let presetMainSubgroupTitle = mainSubGroupTitle.text ?? "new main subgroup title"
        let mainSubGroupItemsString = mainSubGroupItems.text ?? ""
        let mainSubGroupItems = mainSubGroupItemsString.split(separator: "/").map(String.init)
        let secondarySubGroupTitle = self.secondarySubGroupTitle.text ?? "new secondary subgroup title"
        let secondarySubGroupItemsString = self.secondarySubGroupItems.text ?? ""
        let secondarySubGroupItems = secondarySubGroupItemsString.split(separator: "/").map(String.init)
        if (secondarySubGroupItems.count == 0){
            PresetsStorage.shared.presets.append(Preset(title: presetTitle, mainSubGroupTitle: presetMainSubgroupTitle, mainSubGroupItems: mainSubGroupItems, type: .single))
        } else{
            PresetsStorage.shared.presets.append(Preset(title: presetTitle, mainSubGroupTitle: presetMainSubgroupTitle, mainSubGroupItems: mainSubGroupItems, secondarySubGroupTitle: secondarySubGroupTitle, secondarySubGroupItems: secondarySubGroupItems, type: .double))
        }
        
        if let presetViewController = self.presentingViewController as? PresetViewController {
                self.dismiss(animated: true) {
                    presetViewController.presetsCollectionView.reloadData()
                }
            }
    }
    
    
    @objc func showMainSubgroupTitile(sender : UITextView){
        if sender.text.isEmpty{
            saveButtonOutlet.isEnabled = false
            saveButtonOutlet.alpha = 0.5
            mainSubGroupTitle.isHidden = true
            mainSubGroupTitle.text?.removeAll()
            mainSubGroupItems.isHidden = true
            mainSubGroupItems.text?.removeAll()
            secondarySubGroupTitle.isHidden = true
            secondarySubGroupTitle.text?.removeAll()
            secondarySubGroupItems.isHidden = true
            secondarySubGroupItems.text?.removeAll()
        }else{
            let presetTitle = titleTextField.text ?? "New preset"
            let isContain = PresetsStorage.shared.presets.contains { presetTitles in
                presetTitles.self.title == presetTitle
            }
            if (!isContain){
                mainSubGroupTitle.isHidden = false
            }else{
                mainSubGroupTitle.isHidden = true
                mainSubGroupItems.isHidden = true
                secondarySubGroupTitle.isHidden = true
                secondarySubGroupItems.isHidden = true
            }

        }
    }
    
    @objc func showMainSubGroupItems (sender: UITextView){
        if (sender.text.isEmpty){
            saveButtonOutlet.isEnabled = false
            saveButtonOutlet.alpha = 0.5
            mainSubGroupItems.isHidden = true
            mainSubGroupItems.text?.removeAll()
            secondarySubGroupTitle.isHidden = true
            secondarySubGroupTitle.text?.removeAll()
            secondarySubGroupItems.isHidden = true
            secondarySubGroupItems.text?.removeAll()
        }else{
            mainSubGroupItems.isHidden = false
        }
    }
    
    @objc func showSecondarySubgroupTitile( sender : UITextView){
        if sender.text.isEmpty{
            saveButtonOutlet.isEnabled = false
            saveButtonOutlet.alpha = 0.5
            secondarySubGroupTitle.isHidden = true
            secondarySubGroupTitle.text?.removeAll()
            secondarySubGroupItems.isHidden = true
            secondarySubGroupItems.text?.removeAll()
        }else{
            secondarySubGroupTitle.isHidden = false
            saveButtonOutlet.isEnabled = true
            saveButtonOutlet.alpha = 1
        }
    }
    
    @objc func showSeconadarySubGroupItems (sender: UITextView){
        if (sender.text.isEmpty){

            saveButtonOutlet.isEnabled = true
            saveButtonOutlet.alpha = 1
            secondarySubGroupItems.isHidden = true
            secondarySubGroupItems.text?.removeAll()
        }else{
            secondarySubGroupItems.isHidden = false
            saveButtonOutlet.isEnabled = false
            saveButtonOutlet.alpha = 0.5
        }
    }
    @objc func showSvaeButton (sender: UITextView){
        if (sender.text.isEmpty){
            saveButtonOutlet.isEnabled = false
            saveButtonOutlet.alpha = 0.5
        }else{
            saveButtonOutlet.isEnabled = true
            saveButtonOutlet.alpha = 1

        }
    }

}



