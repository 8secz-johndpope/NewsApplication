//
//  FeedNewsController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/10/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FeedNewsController: UIViewController {
    
    fileprivate var arrayOfSources = ["business-insider", "independent", "mtv-news", "rbc", "reuters"]

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func refreshNews(_ sender: Any) {
        let apiCall = APICall()
        apiCall.getAPI(sources: arrayOfSources)
    }
    
}

