//
//  PrefectureCell.swift
//  hw_02
//
//  Created by Takashima on 2017/06/13.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import UIKit
import BonMot

class PrefectureCell: UITableViewCell {
    @IBOutlet weak var prefectureLabel: UILabel!
    
    var name: String?
    
//    var prefectureModel: PrefectureModel?
    
    func updateCell() {
        setupPrefectureLabel()
    }
    
    private func setupPrefectureLabel() {
        let style = StringStyle(
            .font(UIFont.boldSystemFont(ofSize: 16)),
            .color(UIColor.darkGray),
            .tracking(.adobe(100))
        )
        let string = name?.styled(with: style)

        prefectureLabel.attributedText = string
    }
}
