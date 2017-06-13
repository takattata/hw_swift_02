//
//  ForecastCell.swift
//  hw_02
//
//  Created by Takashima on 2017/06/14.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import BonMot
import UIKit

protocol ForecastSetTitleDelegate: class {
    func setTitle(barTitle: String)
}

class ForecastCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var descText: UITextView!

    weak var forecastSetTitleDelegate: ForecastSetTitleDelegate?

    private enum Day: Int {
        case Today
        case Tommorow
        case DATomorrow
    }
    private let DAY: Int = Day.Tommorow.rawValue

//    var title: String?
    var prefectureModel: PrefectureModel?

    func refreshCell(location: (name: String, id: String)) {
        WeatherNetworkRequest(prefectureId: location.id).getWeather { [weak self] response in
            self?.prefectureModel = response
            
//            self?.title = self?.prefectureModel?.title
            self?.forecastSetTitleDelegate?.setTitle(barTitle: (self?.prefectureModel?.title)!)
            self?.setupImage()
            self?.setupTemperatureLabel()
            self?.setupDescLabel()
        }
    }
    
    private func setupImage() {
        let url: URL = URL(string: (prefectureModel?.forecasts![DAY].url!)!)!
        thumbnail.kf.setImage(with: url)
    }
    
    private func setupTemperatureLabel() {
        let style = StringStyle(
            .font(UIFont.systemFont(ofSize: 16)),
            .color(UIColor.gray),
            .tracking(.adobe(100))
        )
        let max: String = prefectureModel!.forecasts![DAY].max!
        let min: String = prefectureModel!.forecasts![DAY].min!
        maxLabel.attributedText = "最高気温: \(max)℃".styled(with: style)
        minLabel.attributedText = "最低気温: \(min)℃".styled(with: style)
    }
    
    private func setupDescLabel() {
        let style = StringStyle(
            .font(UIFont.boldSystemFont(ofSize: 12)),
            .color(UIColor.darkGray),
            .tracking(.adobe(80))
        )
        let desc: String = prefectureModel!.desc!
        descText.attributedText = desc.styled(with: style)
        descText.isEditable = false
    }
}
