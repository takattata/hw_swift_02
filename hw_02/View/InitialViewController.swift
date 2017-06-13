//
//  InitialViewController.swift
//  hw_02
//
//  Created by Takashima on 2017/06/13.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import FontAwesome_swift
import UIKit

class InitialViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
            let nib = UINib(nibName: "PrefectureCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "PrefectureCell")

            let icon = UIImage.fontAwesomeIcon(code: "fa-cog", textColor: UIColor.white, size: CGSize(width: 30, height: 30))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .plain, target: self, action: #selector(self.toInformationView))
            }
    }

    let prefectures: [(name: String, id: String)] = [
        ("埼玉", "110010"),
        ("東京", "130010"),
        ("千葉", "120010"),
        ("静岡", "220010"),
        ("茨城", "080010"),
        ("山梨", "190010"),
        ("群馬", "100010"),
        ("岩手", "030010"),
        ("福島", "070010"),
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPathForSelectedRow, animated: true)
        }
    }

    func toInformationView() {
        let vc: UIViewController = UIStoryboard(name: "InformationViewController", bundle: nil).instantiateInitialViewController()!
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.barTintColor = UIColor.orange
        navController.navigationBar.tintColor = UIColor.white
        navController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.present(navController, animated: true, completion: nil)
        print("to information view!!")
    }
}

extension InitialViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrefectureCell", for: indexPath) as! PrefectureCell
        
        cell.name = prefectures[indexPath.row].name
        cell.updateCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prefectures.count
    }
}

extension InitialViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: WeatherViewController = UIStoryboard(name: "WeatherViewController", bundle: nil).instantiateInitialViewController() as! WeatherViewController
        vc.location = prefectures[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        print("tapped!!")
    }
}
