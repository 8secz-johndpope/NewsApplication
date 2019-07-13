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
       
    }
    
    @IBAction func menuButton(_ sender: Any) {
        let sideMenuMethods = MethodsForSideMenu()
        sideMenuMethods.openSideMenu(uiview: self)
    }
    
}
