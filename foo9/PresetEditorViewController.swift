//
//  PresetEditorViewController.swift
//  foo9
//
//  Created by Pavel Brovkin on 11.03.2024.
//

import UIKit

class PresetEditorViewController: UIViewController {

    
    
    
    @IBOutlet weak var presetTitleLabel: UILabel!
    @IBOutlet weak var mainSubGroupTitleLabel: UILabel!
    @IBOutlet weak var mainSubGroupItems: UISegmentedControl!
    @IBOutlet weak var secondarySubGroupTitleLabel: UILabel!
    @IBOutlet weak var secondarySubGroupItems: UISegmentedControl!
    @IBOutlet weak var editSecondarySubgroupTitle: UIButton!
    @IBOutlet weak var addSecondarySubgrupItem: UIButton!
    @IBOutlet weak var editMainSubgroupTitle: UIButton!
    @IBOutlet weak var addMainSubgrupItem: UIButton!
    

    
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
        secondarySubGroupItems.addTarget(self, action: #selector(editItem(_: )), for: .valueChanged)
    }
    
    @IBAction func addMainSubgroupItem(_ sender: Any) {
        let alert = UIAlertController(title: "Add new item?", message: nil, preferredStyle: .alert)
        alert.addTextField { (textFild) in
            textFild.placeholder = "Enter new item title"
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        
        
        
        let add = UIAlertAction(title: "Add new", style: .default, handler:{ [self, weak alert] (_) in
            let textField = alert?.textFields![0].text ?? "New preset"
            let isContain = PresetsStorage.shared.presets[indexPath].mainSubGroupItems!.contains{ items in
                items == textField
            }
            if (!isContain){
                PresetsStorage.shared.presets[indexPath].mainSubGroupItems!.append(textField)
                setupSG()
                if let presetViewController = self.presentingViewController as? PresetViewController {
                    presetViewController.presetsCollectionView.reloadData()
                }
            }
            else {
                let alert2 = UIAlertController(title: "Failed", message: "This item already exists ", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel)
                alert2.addAction(ok)
                self.present(alert2, animated: true)
            }
            
        })
        alert.addAction(add)
        self.present(alert, animated: true)
        
        
        
    }
    
    @IBAction func addSecondarySubgroupItem(_ sender: Any) {
        let alert = UIAlertController(title: "Add new item?", message: nil, preferredStyle: .alert)
        alert.addTextField { (textFild) in
            textFild.placeholder = "Enter new item title"
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        
        
        
        let add = UIAlertAction(title: "Add?", style: .default, handler:{ [self, weak alert] (_) in
            let textField = alert?.textFields![0].text ?? "New preset"
            let isContain = PresetsStorage.shared.presets[indexPath].secondarySubGroupItems!.contains{ items in
                items == textField
            }
            if (!isContain){
                PresetsStorage.shared.presets[indexPath].secondarySubGroupItems?.append(textField)
                secondarySubGroupItems.removeAllSegments()
                for (index, item) in PresetsStorage.shared.presets[indexPath].secondarySubGroupItems!.enumerated(){
                    secondarySubGroupItems.insertSegment(withTitle: item, at: index, animated: false)
                }
            }
            else {
                let alert2 = UIAlertController(title: "Failed", message: "This item already exists ", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .cancel)
                alert2.addAction(ok)
                self.present(alert2, animated: true)
            }
            
        })
        alert.addAction(add)
        self.present(alert, animated: true)
    }
    
    @IBAction func editPresetTitle(_ sender: Any) {
        let alert = UIAlertController(title: "Change preset title?", message: nil, preferredStyle: .alert)
        alert.addTextField { (textFild) in
            textFild.text = PresetsStorage.shared.presets[self.indexPath].title
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        let edit = UIAlertAction(title: "Edit", style: .default, handler:{ [self, weak alert] (_) in
            let textField = alert?.textFields![0].text ?? "New preset title"
            
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
            textField.text = PresetsStorage.shared.presets[self.indexPath].mainSubGroupTitle
            
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
    
    @IBAction func editSecondarySubGroupTitle(_ sender: Any) {
        let alert = UIAlertController(title: "Change preset secondary subGroup title?", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = PresetsStorage.shared.presets[self.indexPath].secondarySubGroupTitle
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        let edit = UIAlertAction(title: "Edit", style:.default, handler: { [self, weak alert] (_) in
            let textField = alert?.textFields![0].text ?? "New main subgroup title"
            PresetsStorage.shared.presets[indexPath].secondarySubGroupTitle = textField
            secondarySubGroupTitleLabel.text = textField
        })
        alert.addAction(edit)
        self.present(alert, animated: true)
    }
    

    


}

extension PresetEditorViewController{
    func setupLabels(){
        preset = PresetsStorage.shared.presets[indexPath]
        presetTitleLabel.text = preset.title
        mainSubGroupTitleLabel.text = preset.mainSubGroupTitle
        
        switch (preset.type){
        case (.none):
            secondarySubGroupTitleLabel.isHidden = true
            secondarySubGroupItems.isHidden = true
            mainSubGroupTitleLabel.isHidden = true
            mainSubGroupItems.isHidden = true
            editSecondarySubgroupTitle.isHidden = true
            editMainSubgroupTitle.isHidden = true
            addSecondarySubgrupItem.isHidden = true
            addMainSubgrupItem.isHidden = true
            
        case .single:
            secondarySubGroupTitleLabel.isHidden = true
            secondarySubGroupItems.isHidden = true
            editSecondarySubgroupTitle.isHidden = true
            mainSubGroupItems.removeAllSegments()
            for (index, item) in preset.mainSubGroupItems!.enumerated(){
                mainSubGroupItems.insertSegment(withTitle: item, at: index, animated: false)
            }
            addSecondarySubgrupItem.isHidden = true
        case .double:
            editSecondarySubgroupTitle.isHidden = false
            secondarySubGroupTitleLabel.isHidden = false
            secondarySubGroupItems.isHidden = false
            secondarySubGroupTitleLabel.text = preset.secondarySubGroupTitle
            secondarySubGroupItems.removeAllSegments()
            
            if preset.secondarySubGroupItems != nil{
                for (index, item) in preset.secondarySubGroupItems!.enumerated(){
                    self.secondarySubGroupItems.insertSegment(withTitle: item, at: index, animated: false)
                }
            }
            
            
        }
        
        
  
        
    }
    func setupSG(){
        preset = PresetsStorage.shared.presets[indexPath]
        mainSubGroupItems.removeAllSegments()
        for (index, item) in preset.mainSubGroupItems!.enumerated(){
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
    
    func setEditSubGroupItemsAlert(sender : String){
        
        
        view.addSubview(editSubGroupItemsAlert)
        editSubGroupItemsAlert.center = view.center
        editSubGroupItemsAlert.setupAlert(title: "Edit?", leftButton: "Cancel", rightButton: "Edit", middleButton: "Delete", sender: sender)
        animateIn()

        
    }

}

extension PresetEditorViewController : EditSubGroupItemsAlertDelegate{
    
    
    
    
    
    func leftButtonTapped() {
        
        animateOut()
        
    }
    
    func rightButtonTapped(sender: String) {
        
        var contaner = [String]()
        var segmentedControl = UISegmentedControl()
        
        switch (sender){
            case "mainSubGroupItems" :
                contaner = PresetsStorage.shared.presets[indexPath].mainSubGroupItems!
                segmentedControl = self.mainSubGroupItems
            case "secondarySubGroupItems":
                contaner = PresetsStorage.shared.presets[indexPath].secondarySubGroupItems!
                segmentedControl = self.secondarySubGroupItems
        default:
            contaner = [String]()
            segmentedControl = UISegmentedControl()
        }
        
        
        let textField = editSubGroupItemsAlert.textField
        let isContain = contaner.contains { item in
            item == textField?.text
        }
        if (!isContain){
            
            switch (sender){
                case "mainSubGroupItems" :
                    PresetsStorage.shared.presets[indexPath].mainSubGroupItems![segmentedControl.selectedSegmentIndex] = (textField?.text)!
                case "secondarySubGroupItems":
                PresetsStorage.shared.presets[indexPath].secondarySubGroupItems?[segmentedControl.selectedSegmentIndex] = (textField?.text)!
                    
            default:
                contaner = [String]()
                segmentedControl = UISegmentedControl()
            }
            segmentedControl.setTitle(textField?.text, forSegmentAt: segmentedControl.selectedSegmentIndex)
            
            animateOut()
            textField?.text = ""
        } else {
            let alert = UIAlertController(title: "Failed", message: "This item is already exists ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .cancel)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
        
    }
    
    func middleButtonTapped(sender: String) {
        
        var contaner :[String]!
        var segmentedControl : UISegmentedControl!
        
        switch (sender){
            case "mainSubGroupItems" :
                contaner = PresetsStorage.shared.presets[indexPath].mainSubGroupItems
                segmentedControl = self.mainSubGroupItems
            case "secondarySubGroupItems":
            contaner = PresetsStorage.shared.presets[indexPath].secondarySubGroupItems!
            segmentedControl = self.secondarySubGroupItems
        default:
            contaner = [String]()
            segmentedControl = UISegmentedControl()
        }
        
        let countItemsInSubgroup = contaner.count
        let selectedIndex = segmentedControl.selectedSegmentIndex
        
        if (countItemsInSubgroup > 1){
            
            switch (sender){
                case "mainSubGroupItems" :
                PresetsStorage.shared.presets[indexPath].mainSubGroupItems!.remove(at: selectedIndex)
                mainSubGroupItems.removeAllSegments()
                for (index, item) in PresetsStorage.shared.presets[indexPath].mainSubGroupItems!.enumerated(){
                    mainSubGroupItems.insertSegment(withTitle: item, at: index, animated: false)
                }
                    
                case "secondarySubGroupItems":
                PresetsStorage.shared.presets[indexPath].secondarySubGroupItems!.remove(at: selectedIndex)
                secondarySubGroupItems.removeAllSegments()
                for (index, item) in PresetsStorage.shared.presets[indexPath].secondarySubGroupItems!.enumerated(){
                    secondarySubGroupItems.insertSegment(withTitle: item, at: index, animated: false)
                }
                
            default:
                contaner = [String]()
                segmentedControl = UISegmentedControl()
            }
            
            animateOut()

            
        } else{
            let alert = UIAlertController(title: "Failed", message: "This  is last item", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        
    }
    
    @objc func editItem(_ sender: UISegmentedControl) {
        if (sender == mainSubGroupItems){
            setEditSubGroupItemsAlert(sender: "mainSubGroupItems")
        }else{
            setEditSubGroupItemsAlert(sender: "secondarySubGroupItems")
        }
    }
    
    
}
