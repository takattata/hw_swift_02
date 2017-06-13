//
//  InfoNameCell.swift
//  hw_02
//
//  Created by Takashima on 2017/06/15.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import UIKit

protocol InfoNameDelegate: class {
    func setName(name: String)
}

class InfoNameCell: UITableViewCell {
    @IBOutlet weak var nameText: UITextField!
    
    weak var delegate: InfoNameDelegate?
    
    func setDelegate() {
        self.nameText.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (nameText.isFirstResponder) {
            nameText.resignFirstResponder()
        }
    }
}

extension InfoNameCell: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        delegate?.setName(name: nameText.text!)

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
