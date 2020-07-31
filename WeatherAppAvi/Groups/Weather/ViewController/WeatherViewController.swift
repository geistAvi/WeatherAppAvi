//
//  WeatherViewController.swift
//  WeatherAppAvi
//
//  Created by Alexandr Avizhits on 14.04.2020.
//  Copyright © 2020 AA. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // - Data
    private var cities = [CityModel]()
    private var weathers = [WeatherModel]()
    
    // - URLSession
    private let session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: -
// MARK: - Collection View Data Source

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewCell", for: indexPath) as! WeatherCollectionViewCell
        cell.set(city: cities[indexPath.item])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentIndex = Int(collectionView.contentOffset.x / scrollView.frame.size.width)
        let  pageNumber = scrollView .contentOffset .x / scrollView .frame .size .width
        pageControll.currentPage = Int(pageNumber)
        if currentIndex == 0 {
            pageControll.currentPageIndicatorTintColor = UIColor.red
        } else if currentIndex == 1{
            pageControll.currentPageIndicatorTintColor =  UIColor.yellow
        } else {
            pageControll.currentPageIndicatorTintColor =  UIColor.green
        }
    }
}

// MARK: -
// MARK: - Collection View Delegate

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let currentCity = cities[indexPath.row]
//        let currentWeather = weathers[indexPath.row]
//        let animateVC = UIStoryboard(name: "Animation", bundle: nil).instantiateInitialViewController() as! AnimationViewController
//
//        animateVC.cityName = currentCity.name
//        animateVC.cityTemp = String(String(format: "%0.1f", currentWeather.main.temp) + "°" )
//        animateVC.cityImage = UIImage(named: currentCity.image) ?? UIImage()
//
//        if currentWeather.main.temp >= 12 {
//            animateVC.weatherImage = UIImage(named: "sun") ?? UIImage()
//        } else if currentWeather.main.temp < 12 && currentWeather.main.temp >= 0 {
//            animateVC.weatherImage = UIImage(named: "rain") ?? UIImage()
//        } else if currentWeather.main.temp < 0 {
//            animateVC.weatherImage = UIImage(named: "cloud") ?? UIImage()
//        }
//        present(animateVC, animated: true, completion: nil)
//
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let tableViewController = UIStoryboard(name: "Table", bundle: nil).instantiateInitialViewController() as! TableViewController
           tableViewController.weathers = weathers
           tableViewController.modalPresentationStyle = .overFullScreen
           present(tableViewController, animated: true, completion: nil)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        return CGSize(width: width, height: height)
    }
    
}

// MARK: -
// MARK: - Configure

private extension WeatherViewController {
    
    func configure() {
        configureUI()
        configurePageControll()
        configureCollectionView()
        configureWeather()
    }
    
    func configureUI() {
        collectionView.isHidden = true
        pageControll.isHidden = true
        activityIndicatorView.startAnimating()
    }
    
    func configurePageControll() {
        pageControll.numberOfPages = 3
        pageControll.currentPageIndicatorTintColor = UIColor.red
    }
    
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: -
// MARK: - Weather

private extension WeatherViewController {
    
    func configureWeather() {
        getWeatherFor(lan: "37.757346", long: "-122.443102") { [weak self] (weather) in
            self?.weathers.append(weather ?? WeatherModel())
            self?.getWeatherFor(lan: "40.699810", long: "-73.941933", completion: { [weak self] (weather) in
                self?.weathers.append(weather ?? WeatherModel())
                self?.getWeatherFor(lan: "34.013332", long: "-118.259332", completion: { (weather) in
                    self?.weathers.append(weather ?? WeatherModel())
                    self?.configureCities()
                })
            })
        }
    }
    
    func getWeatherFor(lan: String, long: String, completion: @escaping ((_ weaher: WeatherModel?) -> ()) ) {
        guard var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather") else { return }
        urlComponents.query = "lat=\(lan)&lon=\(long)&appid=8f9cd6e7f4b0ba4cbb6c624027015273"
        
        guard let url = urlComponents.url else { return }
        let task = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                var weather: WeatherModel?
                do {
                    weather = try? JSONDecoder().decode(WeatherModel.self, from: data)
                } catch {
                    print("JSON decode error: \(error.localizedDescription)")
                }
                completion(weather)
            }
        }
        task.resume()
    }
    
    func configureCities() {
        let laWeather = weathers[0]
        let sfWeather = weathers[1]
        let nyWeather = weathers[2]
        
        let la = CityModel(name: laWeather.name, text: "Hot enough to fry eggs on car tops", temperature: laWeather.main.temp, image: "LA", color: .blue)
        let sf = CityModel(name: sfWeather.name, text: "Spinning pocket of instability", temperature: sfWeather.main.temp, image: "SF", color: .white)
        let ny = CityModel(name: nyWeather.name, text: "Pea soup fog", temperature: nyWeather.main.temp, image: "NY", color: .black)
        
        cities = [la, sf, ny]
        
        DispatchQueue.main.async { [weak self] in
            self?.updateUI()
            self?.collectionView.reloadData()
        }
    }
    
    func updateUI() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        collectionView.isHidden = false
        pageControll.isHidden = false
    }
    
}
