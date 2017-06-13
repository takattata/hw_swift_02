//
//  SystemButton.swift
//  hw_02
//
//  Created by Takashima on 2017/06/14.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import UIKit

class SystemButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setTitleColor(UIColor.white, for: UIControlState.normal)
        backgroundColor = UIColor.red
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.magenta.cgColor
    }
}
