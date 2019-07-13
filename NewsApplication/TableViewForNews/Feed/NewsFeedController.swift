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
    
    //MARK: Контроллер показывает список новостей взятых поочереди из новостных лент, которые пользователь выбирает в Источниках. По дефолту подгружаются новости из 5 источников. Работает Pull to Refresh(срабатывает, но так как новостные ленты обновляются нечасто, ничего нового не подгружается) и Infinite Scrolling(информация ниже).
    
    let transtion = TransitionClass()
    var topView: UIView?
    var fetchingMore = false
    
    var numberOfPosts = 10
    
    fileprivate let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshFunction(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @objc fileprivate func refreshFunction(sender: UIRefreshControl) {
        self.getAPI(sources: UserData.shared.subsId)
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
        getAPI(sources: UserData.shared.subsId)
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
    
    //MARK: Здесь срабатывает fakeAPI() для того чтобы продемонстрировать то что бесконечная прокрутка работает. Если вставлять API из источников, то скорее всего ничего нового не подгрузится. Более детально напишу к fakeAPI()
    fileprivate func beginFetch() {
        fetchingMore = true
        print("infinite scrolling will upload in 2 seconds")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.fakeAPI(count: self.numberOfPosts)
            self.fetchingMore = false
        })
    }
}


