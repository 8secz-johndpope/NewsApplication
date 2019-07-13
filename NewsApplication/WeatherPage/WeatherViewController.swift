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
    
    //MARK: Отображает погоду в городе. Показывает время (каждые 3 часа), минимальную и максимальную температуру (часто совпадают) и общий прогноз.
    
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
        cityLabel.text = UserData.shared.city
        weatherTable.delegate = self
        weatherTable.dataSource = self
        self.getWeatherAPI(city: UserData.shared.city)
    }
}
