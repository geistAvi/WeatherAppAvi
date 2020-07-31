//
//  WeatherCollectionViewCell.swift
//  WeatherAppAvi
//
//  Created by Alexandr Avizhits on 14.04.2020.
//  Copyright © 2020 AA. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    // - UI
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(city: CityModel) {
        cityLabel.text = city.name
        textLabel.text = city.text
        temperatureLabel.text = String(format: "%0.1f", city.temperature) + "°"
        cityImageView.image = UIImage(named: city.image)
        textLabel.textColor = city.color
        cityLabel.textColor = city.color
        temperatureLabel.textColor = city.color
    }
}
