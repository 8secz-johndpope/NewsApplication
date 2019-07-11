//
//  Sources.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

class Sources {
    static let shared = Sources()
    var arrayOfSources = ["business-insider", "independent", "mtv-news", "rbc", "reuters"]
    var arrayOfSourcesNames = ["Business Insider", "Independent", "MTV News", "RBC", "Reuters"]
    
    var countriesAndCities: [String:[String]] = ["Ukraine":["Kyiv", "Lviv", "Kharkiv", "Dnipro"], "Poland": ["Warsaw", "Krakow", "Lodz", "Poznan"], "Germany": ["Berlin", "Munich", "Cologne", "Hamburg"]]
    
    var weatherCity = "Kyiv"
}

