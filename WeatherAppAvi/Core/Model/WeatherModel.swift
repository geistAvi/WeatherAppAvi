//
//  WeatherModel.swift
//  WeatherAppAvi
//
//  Created by Alexandr Avizhits on 19.04.2020.
//  Copyright © 2020 AA. All rights reserved.
//

import UIKit

class WeatherModel: Decodable {
    
    var name = ""
    var main = MainWeatherModel()
    
    enum CodingKeys: String, CodingKey {
        case name, main
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        main = try values.decodeIfPresent(MainWeatherModel.self, forKey: .main) ?? MainWeatherModel()
    }
    
}
