//
//  WeatherNetworkRequest.swift
//  hw_02
//
//  Created by Takashima on 2017/06/13.
//  Copyright © 2017年 taka. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON

class WeatherNetworkRequest {
    let prefectureId: String
    
    init(prefectureId: String) {
        self.prefectureId = prefectureId
    }
    
    func getWeather(completionHandler: ((PrefectureModel) -> Void)?) {
        let url = "http://weather.livedoor.com/forecast/webservice/json/v1?city=\(prefectureId)"
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value).object
                
                guard let object = Mapper<PrefectureModel>().map(JSONObject: json) else {
                    print("Can't convert!!")
                    return
                }
                
                completionHandler?(object)
            case .failure(let error):
                print(error)
            }
        }
    }
}
