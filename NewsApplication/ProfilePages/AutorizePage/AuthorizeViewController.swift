//
//  AuthorizeViewController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AuthorizeViewController: UIViewController {
    
    @IBOutlet weak var signUpLbl: UILabel!
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var enterButtonOutlet: UIButton!
     var reference: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginTF.delegate = self
        passTF.delegate = self
        reference = Database.database().reference()
        NotificationCenter.default.addObserver(self, selector: #selector(willShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willHideNotification(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        loginTF.text = ""
        passTF.text = ""
    }
    
    @IBAction func enterButton(_ sender: Any) {
        checkCredentials()
    }
    
    @objc func willChangeFrame(_ notification: NSNotification) {
       view.frame.origin.y = 0
    }
    
    @objc func willShowNotification(_ notification: NSNotification) {
        
        guard let userInfo = notification.userInfo else {return}
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        view.frame.origin.y -= keyboardFrame.height / 4
    }
    
    @objc func willHideNotification(_ notification: NSNotification) {
        view.frame.origin.y = 0
    }
}
