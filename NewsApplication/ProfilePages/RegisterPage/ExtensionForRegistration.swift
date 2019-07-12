//
//  ExtensionForRegistration.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/12/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

extension RegisterViewController: UITextFieldDelegate {
    
    //MARK:
    func checkData() {
        guard let email = emailTF.text else {return}
        guard let pass = passwordTF.text else {return}
        guard let confirm = confirmTF.text else {return}
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        let validate = emailPredicate.evaluate(with: email)
        
        if validate == false {
            callAlertForEmail()
        }
        
        if email.isEmpty || pass.isEmpty || confirm.isEmpty {
            callAlertIfEmpty()
        }
        
        if pass != confirm {
            callAlertIfNotEqual()
        } else {
            Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
                if err == nil {
                    let securityData: [String: String] = ["email": email, "pass": pass]
                    let key = email.replacingOccurrences(of: ".", with: "")
                    self.reference.child("UsersDB").child(key).setValue(securityData) { (error, refer) in
                        if error == nil {
                            let key = email.replacingOccurrences(of: ".", with: "")
                            UserData.shared.email = key
                            UserData.shared.password = pass
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "ProfilePageViewController")
                            self.present(vc, animated: true, completion: nil)
                            print("Save to UsersDB succeeded")
                        } else {
                            print("failed to save to UsersDB")
                        }
                    }
                } else {
                    print("register failure")
                }
            }
        }
    }
    
    //MARK:
    func callAlertForEmail() {
        let alert = UIAlertController(title: "Enter correct email address", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .destructive, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK:
    func callAlertIfEmpty() {
        let alert = UIAlertController(title: "Provide complete information", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .destructive, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //MARK
    func callAlertIfNotEqual() {
        let alert = UIAlertController(title: "Passwords do not match", message: "Try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .destructive, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
}
