//
//  InfoDescCell.swift
//  hw_02
//
//  Created by Takashima on 2017/06/15.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import UIKit

protocol InfoDescDelegate: class {
    func setContent(content: String)
    func scrollUpView()
    func scrollDownView()
}

class InfoDescCell: UITableViewCell {
    @IBOutlet weak var descText: UITextView!
    
    weak var delegate: InfoDescDelegate?
    
    func setDelegate() {
        self.descText.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (descText.isFirstResponder) {
            descText.resignFirstResponder()
        }
    }
}

extension InfoDescCell: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        delegate?.scrollUpView()
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        delegate?.scrollDownView()
        delegate?.setContent(content: descText.text)
        
        return true
    }
}
