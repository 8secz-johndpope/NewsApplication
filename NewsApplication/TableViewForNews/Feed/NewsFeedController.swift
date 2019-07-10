//
//  NewsFeedController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/10/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NewsFeedController: UITableViewController {
    
    fileprivate var fetchingMore = false
    fileprivate var numberOfRows: Int = 0
    
    fileprivate var arrayOfSources = ["business-insider", "independent", "mtv-news", "rbc", "reuters"]
    fileprivate var arrayOfKeyWords = ["business", "sport", "art"]
    fileprivate var arrayOfTitles: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    fileprivate var arrayOfDescription: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    fileprivate var arrayOfImageLinks: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getAPI(sources: arrayOfSources)
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTitles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedCell", for: indexPath) as! NewsFeedCell
        cell.labelTitle.text = arrayOfTitles[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DescriptionViewController") as! DescriptionViewController
        vc.titleLbl = arrayOfTitles[indexPath.row]
        vc.descriptionTV = arrayOfDescription[indexPath.row]
        vc.imageviewLink = arrayOfImageLinks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginFetch()
            }
        }
    }
    
    fileprivate func beginFetch() {
        fetchingMore = true
        print("beginFetch")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.api2()
            self.fetchingMore = false
        })
    }
    
    func api2() {
        let urrBase = "https://newsapi.org/v2/everything?q=business&pageSize=30&from=2019-06-15&apiKey=03a051ab4ea64854a68c2556325f42a5"
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
    }
    
    
    @IBAction func refreshButton(_ sender: Any) {
        getAPI(sources: arrayOfSources)
        print(arrayOfTitles)
    }
    
    fileprivate func getAPI(sources: Array<String>) {
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
