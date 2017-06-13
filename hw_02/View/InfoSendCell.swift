//
//  InfoSendCell.swift
//  hw_02
//
//  Created by Takashima on 2017/06/15.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import UIKit

protocol InfoSenderDelegate: class {
    func sendMessage()
}

class InfoSendCell: UITableViewCell {
    @IBOutlet weak var sendButton: SystemButton!

    weak var infoSenderDelegate: InfoSenderDelegate?
    
    func setButton() {
        sendButton.addTarget(self, action: #selector(self.send), for: UIControlEvents.touchDown)
    }
    
    func send() {
        infoSenderDelegate?.sendMessage()
    }
}
