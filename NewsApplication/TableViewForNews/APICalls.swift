////
////  APICalls.swift
////  NewsApplication
////
////  Created by Vladyslav on 7/10/19.
////  Copyright © 2019 Vladyslav. All rights reserved.
////
//
//import UIKit
//import Alamofire
//import SwiftyJSON
//
//class APICall {
//    func getAPI(sources: Array<String>) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "NewsFeedController") as! NewsFeedController
//        for i in sources {
//            let baseURL = "https://newsapi.org/v2/top-headlines?sources="
//            let sourceId = i
//            let apiKey = "&apiKey=03a051ab4ea64854a68c2556325f42a5"
//            guard let url = URL(string: baseURL + sourceId + apiKey) else {return}
//            Alamofire.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: nil).responseData { (response) in
//                guard let data = response.data else {return}
//                guard let json = try? JSON(data: data) else {return}
//                guard let dict = json.dictionary else {return}
//                //            print(dict)
//                guard let source = dict["articles"]?.array else {return}
//                for i in source {
//                    guard let newDict = i.dictionary else {return}
//                    guard let title = newDict["title"]?.string else {return}
////                    print(title)
//                    vc.arrayOfTitles.append(title)
//                    guard let description = newDict["description"]?.string else {return}
//                    print(description)
//                    vc.arrayOfDescription.append(description)
//                    let imageLink = newDict["urlToImage"]?.string
//                    if imageLink == nil {
////                        print("no images")
//                        vc.arrayOfImageLinks.append("no link")
//                    } else {
////                        print(imageLink!)
//                        vc.arrayOfImageLinks.append(imageLink!)
//                    }
//                }
//            }
//        }//for
//    }
//}
