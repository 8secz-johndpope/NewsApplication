//
//  LinksViewController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/10/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

class LinksViewController: UIViewController {
    
    let transtion = TransitionClass()
    var topView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func button(_ sender: UIBarButtonItem) {
        let sideMenuMethods = MethodsForSideMenu()
        sideMenuMethods.openSideMenu(uiview: self)
    }
}

