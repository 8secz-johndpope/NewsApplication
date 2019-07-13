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
    let sideMenuMethods = MethodsForSideMenu()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuMethods.openSideMenu(uiview: self)
    }
    
    @IBAction func menuButton(_ sender: Any) {
        sideMenuMethods.openSideMenu(uiview: self)
    }
    
}
