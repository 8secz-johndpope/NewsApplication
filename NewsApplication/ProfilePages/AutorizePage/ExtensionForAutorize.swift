//
//  ExtensionForAutorize.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/12/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

extension AuthorizeViewController: UITextFieldDelegate {
    
    //MARK:
    func checkCredentials() {
        guard let login = loginTF.text else {return}
        guard let pass = passTF.text else {return}
        if login.isEmpty || pass.isEmpty {
            alertForLoginFailure()
        }
        
        Auth.auth().signIn(withEmail: login, password: pass) { (result, error) in
            if error == nil {
                UserData.shared.email = login
                let key = UserData.shared.email.replacingOccurrences(of: ".", with: "")
                self.reference.child("UsersDB").child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    guard let value = snapshot.value as? NSDictionary else {return}
                    guard let email = value["email"] else {return}
                    UserData.shared.email = "\(email)"
                    guard let password = value["pass"] else {return}
                    UserData.shared.password = "\(password)"
                    guard let name = value["name"] else {return}
                    UserData.shared.name = "\(name)"
                    guard let secondName = value["secondName"] else {return}
                    UserData.shared.secondName = "\(secondName)"
                    guard let phone = value["phone"] else {return}
                    UserData.shared.phone = "\(phone)"
                    guard let date = value["dateOfBirth"] else {return}
                    UserData.shared.yearOfBirth = "\(date)"
                    guard let country = value["country"] else {return}
                    UserData.shared.country = "\(country)"
                    guard let city = value["city"] else {return}
                    UserData.shared.city = "\(city)"
                    guard let subs = value["subs"] as? NSArray else {return}
                    for i in subs {
                        UserData.shared.subs.append("\(i)")
                    }
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "BlankPageControllerNav")
                    self.present(vc, animated: true, completion: nil)
                }) { (error) in
                    print(error.localizedDescription)
                }
                
            } else {
                print("failed to login")
            }
        }
    }
    
    //MARK:
    func alertForLoginFailure() {
        let alert = UIAlertController(title: "Incorrect pass or login", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .destructive, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
