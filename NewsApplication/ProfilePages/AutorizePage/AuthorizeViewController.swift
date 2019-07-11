//
//  AuthorizeViewController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

class AuthorizeViewController: UIViewController {
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loginTF.delegate = self
        passTF.delegate = self
        
    }
    
    @IBAction func enterButton(_ sender: Any) {
        checkCredentials()
    }
    
   
}
