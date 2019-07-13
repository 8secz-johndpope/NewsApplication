//
//  FakeAPI.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/13/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


extension NewsFeedController {
    
    //MARK: Я написал эту функцию для того чтобы подгружать новую информацию. Если постоянно обновлять новости из источников которые пользователь выбрал, тогда нельзя будет продемонстрировать бесконечную ленту. Также еще проблема состоит в том, что сервис позволяет получить до 100 постов в запросе. Тоесть, можно будет получить только 100 релевантных постов. Эта функция получает 100 постов на бизнес тематику для демонстрации, подгружая с каждой новой прокруткой +10 постов.
    
    func fakeAPI(count: Int) {
        let urrBase = "https://newsapi.org/v2/everything?q=business&pageSize=\(count)&from=2019-06-15&apiKey=03a051ab4ea64854a68c2556325f42a5"
        guard let url = URL(string: urrBase) else {return}
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
        numberOfPosts += 10
    }
}
