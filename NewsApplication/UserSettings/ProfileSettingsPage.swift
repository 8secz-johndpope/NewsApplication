//
//  ProfileSettingsPage.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/13/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import ActionSheetPicker_3_0

class ProfileSettingsPage: UIViewController {
    var reference: DatabaseReference!
    let transtion = TransitionClass()
    var topView: UIView?
    
    let arrayOfCountries: [String] = {
        var array = [String]()
        for (key, _) in Sources.shared.countriesAndCities {
            array.append(key)
        }
        return array
    }()
    
    var arrayOfCities: [String] = []
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var secondNameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var countryOutlet: UIButton!
    @IBOutlet weak var cityOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reference = Database.database().reference()
        nameTF.text = UserData.shared.name
        secondNameTF.text = UserData.shared.secondName
        phoneTF.text = UserData.shared.phone
        countryOutlet.setTitle(UserData.shared.country, for: .normal)
        cityOutlet.setTitle(UserData.shared.city, for: .normal)
        
        nameTF.delegate = self
        secondNameTF.delegate = self
        phoneTF.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateDBValues()
    }
    
    @IBAction func countryButton(_ sender: Any) {
        actionPickerOne()
    }
    
    @IBAction func cityButton(_ sender: Any) {
        actionPickerTwo()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        changePass()
    }
    
}
