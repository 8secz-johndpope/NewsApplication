//
//  ExtensionForFirebase.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/12/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import Firebase
import FirebaseAuth
import FirebaseDatabase


extension ProfilePageViewController {
    
    //MARK: Дозаполняет информацию о пользователе в базу данных. Так же при регистрации пользователя добавляет ему 5 подписок на новостные каналы.
    
    func writeDataToDB() {
        guard let firstName = firstNameTF.text else {return}
        guard let secondName = secondNameTF.text else {return}
        guard let phoneNumber = phoneNumberTF.text else {return}
        guard let dateOfBirth = dateOfBirthButtonOutlet.titleLabel?.text else {return}
        guard let country = countryButtonOutlet.titleLabel?.text else {return}
        guard let city = cityButtonOutlet.titleLabel?.text else {return}
        if firstName.isEmpty || secondName.isEmpty {
            callAlertIf()
            return
        }
        if phoneNumberTF.text?.rangeOfCharacter(from: .letters) != nil || phoneNumber.isEmpty {
            callAlertIf()
        }
        let userID = Auth.auth().currentUser?.uid
        let subs: [String:String] = ["Business Insider": "business-insider", "Independent": "independent", "MTV News":"mtv-news", "RBC":"rbc", "Reuters":"reuters"]
        let securityData: [String: Any] = ["key": userID as Any,
                                           "name": "\(firstName)",
            "secondName": "\(secondName)",
            "phone": "\(phoneNumber)",
            "dateOfBirth": "\(dateOfBirth)",
            "country": "\(country)",
            "city": "\(city)",
            "email": UserData.shared.email,
            "pass" : UserData.shared.password,
            "subs": subs]
        reference.child("UsersDB").child(UserData.shared.email).setValue(securityData) { (error, refer) in
            if error == nil {
                UserData.shared.name = "\(firstName)"
                UserData.shared.secondName = "\(secondName)"
                UserData.shared.phone = "\(phoneNumber)"
                UserData.shared.yearOfBirth = "\(dateOfBirth)"
                UserData.shared.country = "\(country)"
                UserData.shared.city = "\(city)"
                for (key, value) in subs {
                    UserData.shared.subs.append("\(key)")
                    UserData.shared.subsId.append("\(value)")
                }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "BlankPageControllerNav")
                self.present(vc, animated: true, completion: nil)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                print(" failed to save to UsersDB")
            }
        }
    }
}
