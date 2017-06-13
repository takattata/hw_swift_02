//
//  InformationViewController.swift
//  hw_02
//
//  Created by Takashima on 2017/06/13.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class InformationViewController: UIViewController {    
    fileprivate enum Cells: Int {
        case Name
        case Address
        case Desc
        case Send
    }
    fileprivate let CellNames: [String] = ["InfoNameCell", "InfoAddressCell", "InfoDescCell", "InfoSendCell"]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
//            tableView.separatorColor = UIColor.white
            tableView.isScrollEnabled = false
        }
    }
    
    fileprivate var keyboardHeight: CGFloat = 0.0
    fileprivate var name: String = ""
    fileprivate var email: String = ""
    fileprivate var content: String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "お問い合わせ"
        let icon = UIImage.fontAwesomeIcon(code: "fa-times", textColor: UIColor.white, size: CGSize(width: 30, height: 30))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(self.toInitialView))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let notification = NotificationCenter.default
        notification.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification?) {
        if let userInfo = notification?.userInfo {
            if let keyboardFrameInfo = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                self.keyboardHeight = keyboardFrameInfo.cgRectValue.height
            }
        }
    }
    
    func toInitialView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension InformationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CellNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: CellNames[index], for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        let cellType: Cells = Cells.init(rawValue: index)!
        //FIXME: 既定クラス作る or UITextViewCellに同じ関数つける?(どのタイミングで?)
        switch cellType {
        case Cells.Name:
            //FIXME: 名前やばい.
            //FIXME: まとめられるはず.
            let castedCell: InfoNameCell = cell as! InfoNameCell
            castedCell.setDelegate()
            castedCell.delegate = self
        case Cells.Address:
            let castedCell: InfoAddressCell = cell as! InfoAddressCell
            castedCell.setDelegate()
            castedCell.delegate = self
        case Cells.Desc:
            let castedCell: InfoDescCell = cell as! InfoDescCell
            castedCell.setDelegate()
            castedCell.delegate = self
            break
        case Cells.Send:
            let castedCell: InfoSendCell = cell as! InfoSendCell
            castedCell.setButton()
            castedCell.infoSenderDelegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension InformationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension InformationViewController: InfoSenderDelegate {
    func sendMessage() {
        var contentText: String = content

        let descCellPath: IndexPath = IndexPath(row: 0, section: Cells.Desc.rawValue)
        if let descCell: InfoDescCell = tableView.cellForRow(at: descCellPath) as? InfoDescCell {
            contentText = contentText.isEmpty ? descCell.descText.text : contentText
        }

        let parameterJSON: JSON = JSON([
            "channel": "#times_taka",
            "username": "test-taka",
            "text": "名前: \(name), メールアドレス: \(email), 本文: \(contentText)"
            ])
        //FIXME: ENV管理.
        Alamofire.request("***slack url***", method: .post, parameters: parameterJSON.dictionaryObject, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            print(response.result)
        }
        toInitialView()
    }
}

extension InformationViewController: InfoDescDelegate {
    func setContent(content: String) {
        self.content = content
    }
    
    func scrollUpView() {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: self.keyboardHeight, right: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: Cells.Desc.rawValue)
        
        self.tableView.contentInset = contentInsets
        self.tableView.scrollIndicatorInsets = contentInsets
        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func scrollDownView() {
        self.tableView.contentInset = UIEdgeInsets.zero
        self.tableView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}

extension InformationViewController: InfoAddressDelegate {
    func setEmail(email: String) {
        self.email = email
    }
}

extension InformationViewController: InfoNameDelegate {
    func setName(name: String) {
        self.name = name
    }
}
