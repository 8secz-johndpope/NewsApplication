//
//  SubsViewController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/10/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

class SubsViewController: UIViewController {
    
    let transtion = TransitionClass()
    var topView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func menu(_ sender: Any) {
        let sideMenuMethods = MethodsForSideMenu()
        sideMenuMethods.openSideMenu(uiview: self)
    }

}

