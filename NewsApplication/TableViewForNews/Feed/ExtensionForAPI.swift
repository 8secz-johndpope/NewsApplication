//
//  ExtensionForAPI.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


extension NewsFeedController {
    func getAPI(sources: Array<String>) {
        for source in sources {
            let baseURL = "https://newsapi.org"
            let endPoint = "/v2/top-headlines?"
            let sourceId = "sources=" + source
            let countParameters = "&pageSize=30"
            let apiKey = "&apiKey=03a051ab4ea64854a68c2556325f42a5"
            guard let url = URL(string: baseURL + endPoint + sourceId + countParameters + apiKey) else {return}
            Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: nil).responseData { (response) in
                guard let data = response.data else {return}
                guard let json = try? JSON(data: data) else {return}
                guard let dict = json.dictionary else {return}
                guard let source = dict["articles"]?.array else {return}
                for i in source {
                    guard let newDict = i.dictionary else {return}
                    guard let title = newDict["title"]?.string else {return}
                    var someNumber = 0
                    for i in self.arrayOfTitles {
                        if i != title {
                            someNumber += 1
                        }
                    }
                    if someNumber == self.arrayOfTitles.count {
                        self.arrayOfTitles.append(title)
                        guard let description = newDict["description"]?.string else {return}
                        self.arrayOfDescription.append(description)
                        let imageLink = newDict["urlToImage"]?.string
                        if imageLink == nil {
                            self.arrayOfImageLinks.append("no link")
                        } else {
                            self.arrayOfImageLinks.append(imageLink!)
                        }
                        someNumber = 0
                    }
                }
            }
        }
    }
}
