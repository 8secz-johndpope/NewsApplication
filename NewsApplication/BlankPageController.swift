//
//  BlankPageController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

class BlankPageController: UIViewController {

    let transtion = TransitionClass()
    var topView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "NewsFeedController")
//        view.addSubview(vc.view)
//        Properties.shared.topView = vc.view
//        addChild(vc)
        
       
    }
    
    @IBAction func menuButton(_ sender: Any) {
        let sideMenuMethods = MethodsForSideMenu()
        sideMenuMethods.openSideMenu(uiview: self)
    }
    
}
