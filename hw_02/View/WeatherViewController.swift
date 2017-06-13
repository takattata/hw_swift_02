//
//  WeatherViewController.swift
//  hw_02
//
//  Created by Takashima on 2017/06/13.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import UIKit
import BonMot
import Kingfisher

class WeatherViewController: UIViewController {
    fileprivate enum Cells: Int {
        case Forecast
        case Alert
    }
    fileprivate let CellNames: [String] = ["ForecastCell", "AlertCell"]
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
//            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            tableView.isScrollEnabled = false
            
            let forecastNib = UINib(nibName: CellNames[Cells.Forecast.rawValue], bundle: nil)
            tableView.register(forecastNib, forCellReuseIdentifier: CellNames[Cells.Forecast.rawValue])
        }
    }
    
    //FIXME: 初期化これで良いのか?
    var location: (name: String, id: String) = ("", "")
    private var prefectureModel: PrefectureModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension WeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return CellNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: CellNames[index], for: indexPath)
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if (index == Cells.Forecast.rawValue) {
            let castedCell: ForecastCell = cell as! ForecastCell
            castedCell.refreshCell(location: location)
            castedCell.forecastSetTitleDelegate = self
        }
        else {
//            case Cells.Alert.rawValue:
            let castedCell: AlertCell = cell as! AlertCell
            castedCell.setButton()
            castedCell.alertDelegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension WeatherViewController: BackSceneDelegate {
    func presentAlert() {
        let alert: UIAlertController = UIAlertController(title: "title", message: "message", preferredStyle: UIAlertControllerStyle.alert)
        
        let action: UIAlertAction = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.cancel,
            handler: { (action: UIAlertAction!) -> Void in
                self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension WeatherViewController: ForecastSetTitleDelegate {
    func setTitle(barTitle: String) {
//        let forecastCell: ForecastCell = tableView.visibleCells[Cells.Forecast.rawValue] as! ForecastCell
        self.title = barTitle
    }
}
