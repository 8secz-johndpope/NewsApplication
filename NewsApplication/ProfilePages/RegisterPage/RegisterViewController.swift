//
//  RegisterViewController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    //MARK: Экран регистрации
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    
    var reference: DatabaseReference!
    

    override func viewDidLoad() {
        navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        emailTF.delegate = self
        passwordTF.delegate = self
        confirmTF.delegate = self
        reference = Database.database().reference()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emailTF.text = ""
        passwordTF.text = ""
        confirmTF.text = ""
    }
    
    @IBAction func registerButton(_ sender: Any) {
        checkData()
    }
    
}
