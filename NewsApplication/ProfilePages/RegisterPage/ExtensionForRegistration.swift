//
//  ExtensionForRegistration.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/12/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

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
