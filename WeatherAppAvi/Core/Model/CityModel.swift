//
//  CityModel.swift
//  WeatherAppAvi
//
//  Created by Alexandr Avizhits on 14.04.2020.
//  Copyright © 2020 AA. All rights reserved.
//

import Foundation
import UIKit

class CityModel {
    
    var name: String
    var text: String
    var temperature: Double
    var image : String
    var color : UIColor
   
    
    init(name:String, text: String, temperature: Double, image: String, color: UIColor) {
    self.name = name
    self.text = text
    self.temperature = temperature
    self.image = image
    self.color = color
        
    }
}
