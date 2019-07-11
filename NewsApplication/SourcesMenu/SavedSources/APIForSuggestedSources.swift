//
//  APIForSuggestedSources.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension SavedSourcesController {
    func getAPI() {
            let baseURL = "https://newsapi.org/v2/sources?language=en&language=ru&apiKey=03a051ab4ea64854a68c2556325f42a5"
            guard let url = URL(string: baseURL) else {return}
            Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: nil).responseData { (response) in
                guard let data = response.data else {return}
                guard let json = try? JSON(data: data) else {return}
                guard let dict = json.dictionary else {return}
                guard let source = dict["sources"]?.array else {return}
                for i in source {
                    guard let newDict = i.dictionary else {return}
                    guard let id = newDict["id"]?.string else {return}
                    guard let name = newDict["name"]?.string else {return}
                    self.suggestedSourcesId.append(id)
                    print(id)
                    self.suggestedSourcesName.append(name)
                }
            }
        }
    }
