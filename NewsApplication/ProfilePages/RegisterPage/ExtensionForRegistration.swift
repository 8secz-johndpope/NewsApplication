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
    
    //MARK: Создает пользователя для аутентификации
    func checkData() {
        guard let email = emailTF.text else {return}
        guard let pass = passwordTF.text else {return}
        guard let confirm = confirmTF.text else {return}
        
        if pass != confirm {
            callAlertIfNotEqual()
        } else {
            Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
                if err == nil {
                    let securityData: [String: String] = ["email": email, "pass": pass]
                    let key = email.checkForbiddenCharacters()
                    self.reference.child("UsersDB").child(key).setValue(securityData) { (error, refer) in
                        if error == nil {
                            UserData.shared.email = key
                            UserData.shared.password = pass
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "ProfilePageViewController")
//                            self.present(vc, animated: true, completion: nil)
                            self.navigationController?.pushViewController(vc, animated: true)
                            print("Save to UsersDB succeeded")
                        } else {
                            print("failed to save to UsersDB")
                        }
                    }
                } else {
                    self.callAlertForEmail()
                    print("register failure")
                }
            }
        }
    }
    
    //MARK: Если ошибка с мейлом
    func callAlertForEmail() {
        let alert = UIAlertController(title: "Enter correct email address", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .destructive, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    //MARK: Если пароли не совпадают
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
