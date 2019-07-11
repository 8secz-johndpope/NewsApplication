//
//  ExtensionForAutorize.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/12/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

extension AuthorizeViewController: UITextFieldDelegate {
    
    //MARK:
    func checkCredentials() {
        guard let login = loginTF.text else {return}
        guard let pass = passTF.text else {return}
        if login.isEmpty || pass.isEmpty {
            alertForLoginFailure()
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
