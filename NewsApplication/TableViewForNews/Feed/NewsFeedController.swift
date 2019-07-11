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
    let transtion = TransitionClass()
    var topView: UIView?
    var fetchingMore = false
    
    var numb = 30
    
    fileprivate let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshFunction(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @objc fileprivate func refreshFunction(sender: UIRefreshControl) {
        api2(count: numb)
        sender.endRefreshing()
    }
    
    var arrayOfTitles: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var arrayOfDescription: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var arrayOfImageLinks: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getAPI(sources: Sources.shared.arrayOfSources)
        tableView.refreshControl = myRefreshControl
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.getAPI(sources: Sources.shared.arrayOfSources)
            self.fetchingMore = false
        })
    }
    
    func api2(count: Int) {
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
                self.arrayOfTitles.insert(title, at: 0)
                guard let description = newDict["description"]?.string else {return}
                self.arrayOfDescription.insert(description, at: 0)
                let imageLink = newDict["urlToImage"]?.string
                if imageLink == nil {
                    self.arrayOfImageLinks.insert("no link", at: 0)
                } else {
                    self.arrayOfImageLinks.insert(imageLink!, at: 0)
                }
                someNumber = 0
            }
            }
            }
        numb += 10
    }
    
    
    @IBAction func menuButton(_ sender: Any) {
        let sideMenuMethods = MethodsForSideMenu()
        sideMenuMethods.openSideMenu(uiview: self)
    }
    
    
    
}


