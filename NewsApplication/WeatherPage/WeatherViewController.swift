//
//  WeatherViewController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherViewController: UIViewController {
    
    var weatherMain: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.weatherTable.reloadData()
            }
        }
    }
    var weatherTempMin: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.weatherTable.reloadData()
            }
        }
    }
    var weatherTempMax: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.weatherTable.reloadData()
            }
        }
    }
    var weatherDate: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.weatherTable.reloadData()
            }
        }
    }
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherTable: UITableView!
    
    let transtion = TransitionClass()
    var topView: UIView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        cityLabel.text = Sources.shared.weatherCity
        weatherTable.delegate = self
        weatherTable.dataSource = self
        getWeatherAPI(city: Sources.shared.weatherCity)
    }
    
    func getWeatherAPI(city: String) {
        DispatchQueue.main.async {
        let basicURL = "http://api.openweathermap.org/data/2.5/forecast?&lang=ru&q=\(city)"
        let apiKey = "&appid=584923265195ec1fdd63a6457480aaad"
        guard let url = URL(string: basicURL + apiKey) else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, err) in
            if let data = data {
                guard let data = try? JSON(data: data) else {return}
                guard let dict = data.dictionary else {return}
                guard let list = dict["list"]?.array else {return}
                for source in list {
                    guard let info = source.dictionary else {return}
                    guard let time = info["dt_txt"]?.string else {return} // time
                    let index = time.index(time.startIndex, offsetBy: 10)
                    let hours = time.suffix(from: index)
                    self.weatherDate.append(String(hours))
                    guard let main = info["main"]?.dictionary else {return}
                        guard let tempMin = main["temp_min"]?.double else {return} // minimum
                        self.weatherTempMin.append("\(Int((tempMin - 273.15).rounded()))°")
                    guard let tempMax = main["temp_max"]?.double else {return} // maximum
                        self.weatherTempMax.append("\(Int((tempMax - 273.15).rounded()))°")
                    guard let weather = info["weather"]?.array else {return}
                    for i in weather {
                        guard let description = i.dictionary else {return}
                        guard let weatherDescr = description["description"] else {return} // общий
                        self.weatherMain.append("\(weatherDescr)")
                    }
                }
            }
            if self.weatherDate.count > 6 {
            self.weatherDate.removeSubrange(6..<self.weatherDate.count)
            self.weatherMain.removeSubrange(6..<self.weatherDate.count)
            self.weatherTempMax.removeSubrange(6..<self.weatherDate.count)
            self.weatherTempMin.removeSubrange(6..<self.weatherDate.count)
            }
        }.resume()
        }
    }
}
