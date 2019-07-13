//
//  ExtensionFirebaseUpdate.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/13/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

extension ProfileSettingsPage: UITextFieldDelegate {

    func changePass() {
        let alert = UIAlertController(title: "Choose new password", message: "Pass must contain at least 8 characters", preferredStyle: .alert)
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter password"
        }
        let action = UIAlertAction(title: "Confirm", style: .default) { (action) in
            guard let tf = alert.textFields?.first?.text else {return}
            if !tf.isEmpty && tf.count > 7 && tf != UserData.shared.password {
                print("ready to change pass")
                Auth.auth().currentUser?.updatePassword(to: tf, completion: { (error) in
                    if error != nil {
                        print("password change error occured")
                    } else {
                        UserData.shared.password = tf
                        let alert = UIAlertController(title: "Password changed successfully", message: nil, preferredStyle: .alert)
                        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            } else {
                let alert = UIAlertController(title: "Incorrect password", message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "Okay", style: .destructive, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
        let action2 = UIAlertAction(title: "Cancel", style: .destructive) { (alert) in
            
        }
        alert.addAction(action)
        alert.addAction(action2)
        present(alert, animated: true, completion: nil)
    }
    
    
    func updateDBValues() {
        guard let nameValue = nameTF.text else {return}
        guard let secondNameValue = secondNameTF.text else {return}
        guard let phoneValue = phoneTF.text else {return}
        guard let countryValue = countryOutlet.titleLabel?.text else {return}
        guard let cityValue = cityOutlet.titleLabel?.text else {return}
        UserData.shared.name = nameValue
        UserData.shared.secondName = secondNameValue
        UserData.shared.phone = phoneValue
        UserData.shared.country = countryValue
        UserData.shared.city = cityValue
        if !nameValue.isEmpty && !secondNameValue.isEmpty && !phoneValue.isEmpty {
            let values: [String:String] = ["name": nameValue, "secondName": secondNameValue, "phone": phoneValue, "country": countryValue, "city": cityValue, "pass": UserData.shared.password]
            reference.child("UsersDB").child(UserData.shared.email).updateChildValues(values) { (error, reference) in
                if error != nil {
                    print("error")
                }
            }
        }
    }
}
