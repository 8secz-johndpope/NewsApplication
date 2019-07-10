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
    
    fileprivate var arrayOfSources = ["business-insider", "independent", "mtv-news", "rbc", "reuters"]
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
    
    
    @IBAction func refreshButton(_ sender: Any) {
        getAPI(sources: arrayOfSources)
        print(arrayOfTitles)
    }
    
    fileprivate func getAPI(sources: Array<String>) {
        for i in sources {
            let baseURL = "https://newsapi.org/v2/top-headlines?sources="
            let sourceId = i
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
                    self.arrayOfTitles.append(title)
                    guard let description = newDict["description"]?.string else {return}
                    self.arrayOfDescription.append(description)
                    let imageLink = newDict["urlToImage"]?.string
                    if imageLink == nil {
                        self.arrayOfImageLinks.append("no link")
                    } else {
                        self.arrayOfImageLinks.append(imageLink!)
                    }
                }
            }
        }
    }
}
