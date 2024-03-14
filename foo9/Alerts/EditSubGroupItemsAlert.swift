//
//  EditSubGroupItemsAlert.swift
//  foo9
//
//  Created by Pavel Brovkin on 13.03.2024.
//

import UIKit


protocol EditSubGroupItemsAlertDelegate {
    func leftButtonTapped()
    func rightButtonTapped()
    func middleButtonTapped()
    
}

class EditSubGroupItemsAlert: UIView {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    
    var delegate : EditSubGroupItemsAlertDelegate?
    
    func setupAlert(title: String, leftButton: String, rightButton: String, middleButton: String ){
        self.titleLable.text = title
        self.leftButton.setTitle(leftButton, for: .normal)
        self.rightButton.setTitle(rightButton, for: .normal)
        self.middleButton.setTitle(middleButton, for: .normal)
        self.rightButton.isEnabled = false
        self.rightButton.alpha = 0.5
        self.textField.addTarget(self, action: #selector(isTextFiledEmpty(sender:)), for: UIControl.Event.editingChanged)
        textField.placeholder = "Input new item"
        
    }
    @IBAction func leftButtonTapped(_ sender: Any) {
        delegate?.leftButtonTapped()
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        delegate?.rightButtonTapped()
    }
    
    @IBAction func middleButtonTapped(_ sender: Any) {
        delegate?.middleButtonTapped()
    }
    @objc func isTextFiledEmpty(sender : UITextView){
        if sender.text.isEmpty{
            self.rightButton.isEnabled = false
            self.rightButton.alpha = 0.5
        }else{
            self.rightButton.isEnabled = true
            self.rightButton.alpha = 1
        }
    }
    
}
