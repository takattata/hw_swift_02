//
//  AlertCell.swift
//  hw_02
//
//  Created by Takashima on 2017/06/14.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import UIKit

protocol BackSceneDelegate: class {
    func presentAlert()
}

class AlertCell: UITableViewCell {
    @IBOutlet weak var alertButton: SystemButton!

    weak var alertDelegate: BackSceneDelegate?
    
    func setButton() {
        alertButton.addTarget(self, action: #selector(self.alertMessage), for: UIControlEvents.touchDown)
    }
    
    func alertMessage() {
        alertDelegate?.presentAlert()
    }
}
