//
//  PrefectureModel.swift
//  hw_02
//
//  Created by Takashima on 2017/06/13.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import ObjectMapper



struct PrefectureModel {
    // description
    var title: String?
    var desc: String?
    var forecasts: [Forecast]?
}

extension PrefectureModel: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        desc <- map["description.text"]
        forecasts <- map["forecasts"]
    }
}

struct Forecast {
    // forecasts
        // image
    var url: String?
        // temperature
    var max: String?
    var min: String?
}

extension Forecast: Mappable {
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        url <- map["image.url"]
        max <- map["temperature.max.celsius"]
        min <- map["temperature.min.celsius"]
    }
}
