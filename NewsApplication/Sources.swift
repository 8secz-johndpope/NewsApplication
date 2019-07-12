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

class UserData {
    static let shared = UserData()
    
    var email: String = ""
    var password: String = ""
    var name: String = ""
    var secondName: String = ""
    var phone: String = ""
    var yearOfBirth: String = ""
    var country: String = ""
    var city: String = ""
    var subs: [String] = []
    var subscriptionsId: [String] = []
}
