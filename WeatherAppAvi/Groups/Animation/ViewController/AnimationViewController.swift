//
//  AnimationViewController.swift
//  WeatherAppAvi
//
//  Created by Alexandr Avizhits on 22.04.2020.
//  Copyright © 2020 AA. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    // - Data
    
    let weatherViewControllerCell = WeatherCollectionViewCell()
    let weatherViewController = WeatherViewController()
    
    var cityName: String = ""
    var cityTemp: String = ""
    var weatherImage: UIImage = UIImage()
    var cityImage: UIImage = UIImage()
    
    // - UI
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    // - Constraint
    
    @IBOutlet weak var weatherImageLeadingConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}

// MARK: -
// MARK: - Animations

private extension AnimationViewController {
    
    func animate() {
        animateWeatherIcon()
        animateTempLabel()
        animateCityLabel()
    }
    
    func animateWeatherIcon() {
        weatherImageLeadingConstraint.constant = view.frame.width / 2 - 240 / 2
        UIView.animate(withDuration: 1.5, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseInOut, animations: { [weak self] in
            self?.view.layoutSubviews()
            }, completion: nil)
    }
    
    func animateTempLabel() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.3, options: [], animations: { [weak self] in
            self?.tempLabel.alpha = 1
            }, completion: nil)
    }
    
    func animateCityLabel() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0.3, options: [], animations: { [weak self] in
            self?.cityLabel.alpha = 1
            }, completion: nil)
    }
}

// MARK: -
// MARK: - Configure

private extension AnimationViewController {
    
    func configure() {
        configureCityLabel()
        configureCityTemp()
        tempLabel.alpha = 0
        cityLabel.alpha = 0
    }
    
    func configureCityLabel() {
        cityImageView.image = cityImage
        cityLabel.text = cityName
        cityLabel.textColor = .blue
    }
    
    func configureCityTemp() {
        tempLabel.text = cityTemp
        tempLabel.textColor = .blue
        weatherImageView.image = weatherImage
    }
}
