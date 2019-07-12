//
//  AuthorizeViewController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

class AuthorizeViewController: UIViewController {
    
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var enterButtonOutlet: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loginTF.delegate = self
        passTF.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @IBAction func enterButton(_ sender: Any) {
        checkCredentials()
    }
    
    @objc func willShowNotification(_ notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else {return}
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        signUpLbl.frame.origin.y -= keyboardFrame.height / 4
        loginTF.frame.origin.y -= keyboardFrame.height / 4
        passTF.frame.origin.y -= keyboardFrame.height / 4
        enterButtonOutlet.frame.origin.y -= keyboardFrame.height / 4
        
    }
}
