//
//  PresetEditorViewController.swift
//  foo9
//
//  Created by Pavel Brovkin on 11.03.2024.
//

import UIKit

class PresetEditorSingleViewController: UIViewController {

    
    
    
    @IBOutlet weak var presetTitleLabel: UILabel!
    @IBOutlet weak var mainSubGroupTitleLabel: UILabel!
    @IBOutlet weak var mainSubGroupItems: UISegmentedControl!

    

    
    var preset = Preset(title: "", mainSubGroupTitle: "", mainSubGroupItems: [String](), type: .single)
    
    private lazy var editSubGroupItemsAlert: EditSubGroupItemsAlert = {
        let editSubGroupItemsAlert: EditSubGroupItemsAlert = EditSubGroupItemsAlert.loadFromNb()
        editSubGroupItemsAlert.delegate = self
        return editSubGroupItemsAlert
    }()
    
    let visualEffectView : UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var indexPath = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
        setupSG()
        setupvisualEffectView()
        mainSubGroupItems.addTarget(self, action: #selector(editItem(_: )), for: .valueChanged)
    }
    

    
    @IBAction func editPresetTitle(_ sender: Any) {
        let alert = UIAlertController(title: "Change preset title?", message: nil, preferredStyle: .alert)
        alert.addTextField { (textFild) in
            textFild.placeholder = "Enter new preset title"
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        let edit = UIAlertAction(title: "Edit", style: .default, handler:{ [self, weak alert] (_) in
            let textField = alert?.textFields![0].text ?? "New preset"
            
            let isContain = PresetsStorage.shared.presets.contains { presets in
                presets.self.title == textField
            }
            if (!isContain){
                PresetsStorage.shared.presets[indexPath].title = textField
                presetTitleLabel.text = textField
                if let presetViewController = self.presentingViewController as? PresetViewController {
                    presetViewController.presetsCollectionView.reloadData()
                }
            } else {
                let alert2 = UIAlertController(title: "Failed", message: "This preset already exists ", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel)
                alert2.addAction(ok)
                self.present(alert2, animated: true)
            }
            
        })
        alert.addAction(edit)
        self.present(alert, animated: true)
    }
    
    @IBAction func editMainSubGroupTitle(_ sender: Any) {
        let alert = UIAlertController(title: "Change preset main subGroup title?", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter new main subGroup title"
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        let edit = UIAlertAction(title: "Edit", style:.default, handler: { [self, weak alert] (_) in
            let textField = alert?.textFields![0].text ?? "New main subgroup title"
            PresetsStorage.shared.presets[indexPath].mainSubGroupTitle = textField
            mainSubGroupTitleLabel.text = textField
        })
        alert.addAction(edit)
        self.present(alert, animated: true)
    }
    
    

    


}

extension PresetEditorSingleViewController{
    func setupLabels(){
        preset = PresetsStorage.shared.presets[indexPath]
        presetTitleLabel.text = preset.title
        mainSubGroupTitleLabel.text = preset.mainSubGroupTitle
        
  
        
    }
    func setupSG(){
        preset = PresetsStorage.shared.presets[indexPath]
        mainSubGroupItems.removeAllSegments()
        for (index, item) in preset.mainSubGroupItems.enumerated(){
            mainSubGroupItems.insertSegment(withTitle: item, at: index, animated: false)
        }
    }
    
    func animateIn(){
        editSubGroupItemsAlert.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        editSubGroupItemsAlert.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            self.editSubGroupItemsAlert.alpha = 1
            self.editSubGroupItemsAlert.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut(){
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 0
            self.editSubGroupItemsAlert.alpha = 0
            self.editSubGroupItemsAlert.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            
        } completion: { (_) in
            self.editSubGroupItemsAlert.removeFromSuperview()
        }

    }
    
    func setupvisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.alpha = 0
        
    }
    
    func setEditSubGroupItemsAlert(){

        view.addSubview(editSubGroupItemsAlert)
        editSubGroupItemsAlert.center = view.center
        editSubGroupItemsAlert.setupAlert(title: "Edit?", leftButton: "Cancel", rightButton: "Edit", middleButton: "Delete")
        animateIn()

        
    }

}

extension PresetEditorSingleViewController : EditSubGroupItemsAlertDelegate{
    func leftButtonTapped() {
        animateOut()
    }
    
    func rightButtonTapped() {

        let textField = editSubGroupItemsAlert.textField
        let isContain = PresetsStorage.shared.presets[indexPath].mainSubGroupItems.contains { item in
            item == textField?.text
        }
        if (!isContain){
            PresetsStorage.shared.presets[indexPath].mainSubGroupItems[mainSubGroupItems.selectedSegmentIndex] = (textField?.text)! // right button is disabled if textfield is empty
            mainSubGroupItems.setTitle(textField?.text, forSegmentAt: mainSubGroupItems.selectedSegmentIndex)
            animateOut()
        } else {
            let alert = UIAlertController(title: "Failed", message: "This item is already exists ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
        
    }
    
    func middleButtonTapped() {
        let countItemsInSubgroup = PresetsStorage.shared.presets[indexPath].mainSubGroupItems.count
        let selectedIndex = mainSubGroupItems.selectedSegmentIndex
        if (countItemsInSubgroup > 1){
            PresetsStorage.shared.presets[indexPath].mainSubGroupItems.remove(at: selectedIndex)
            
            animateOut()
            setupSG()
        } else{
            let alert = UIAlertController(title: "Failed", message: "This  is last item", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
    }
    
    @objc func editItem(_ sender: UISegmentedControl) {
        setEditSubGroupItemsAlert()
    }
    
    
}
