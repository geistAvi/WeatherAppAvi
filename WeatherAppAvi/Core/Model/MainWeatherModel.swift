//
//  MainWeatherModel.swift
//  WeatherAppAvi
//
//  Created by Alexandr Avizhits on 19.04.2020.
//  Copyright © 2020 AA. All rights reserved.
//

import Foundation

class MainWeatherModel: Decodable {
    
    var temp = Double(0)
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        temp = try values.decodeIfPresent(Double.self, forKey: .temp) ?? 0
        temp -= 273
    }
    
}
