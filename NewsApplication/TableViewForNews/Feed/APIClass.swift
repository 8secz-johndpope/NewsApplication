//
//  APIClass.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class APICall {
    
    static let shared = APICall()
    
    var titleArray: [String] = []
    var descriptionArray: [String] = []
    var linksArray: [String] = []
    
    func getAPI(sources: Array<String>) {
        for source in sources {
            let baseURL = "https://newsapi.org/v2/top-headlines?sources="
            let sourceId = source
            let apiKey = "&apiKey=03a051ab4ea64854a68c2556325f42a5"
            guard let url = URL(string: baseURL + sourceId + apiKey) else {return}
            Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: nil).responseData { (response) in
                guard let data = response.data else {return}
                guard let json = try? JSON(data: data) else {return}
                guard let dict = json.dictionary else {return}
                guard let source = dict["articles"]?.array else {return}
                for i in source {
                    guard let newDict = i.dictionary else {return}
                    guard let title = newDict["title"]?.string else {return}
                    var someNumber = 0
                    for i in APICall.shared.titleArray {
                        if i != title {
                            someNumber += 1
                        }
                    }
                    if someNumber == APICall.shared.titleArray.count {
                        APICall.shared.titleArray.append(title)
                        guard let description = newDict["description"]?.string else {return}
                        APICall.shared.descriptionArray.append(description)
                        let imageLink = newDict["urlToImage"]?.string
                        if imageLink == nil {
                            APICall.shared.linksArray.append("no link")
                        } else {
                            APICall.shared.linksArray.append(imageLink!)
                        }
                        someNumber = 0
                    }
                }
            }
        }
        print(APICall.shared.titleArray)
    }

    
    
}
