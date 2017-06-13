//
//  InfoAddressCell.swift
//  hw_02
//
//  Created by Takashima on 2017/06/15.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import UIKit

protocol InfoAddressDelegate: class {
    func setEmail(email: String)
}

class InfoAddressCell: UITableViewCell {
    @IBOutlet weak var addressText: UITextField!
    
    weak var delegate: InfoAddressDelegate?
    
    func setDelegate() {
        self.addressText.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (addressText.isFirstResponder) {
            addressText.resignFirstResponder()
        }
    }
}

extension InfoAddressCell: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        delegate?.setEmail(email: addressText.text!)

        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
