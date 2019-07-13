//
//  ProfilePageViewController.swift
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


class ProfilePageViewController: UIViewController {
    
    //MARK: Контроллер для дополнительной настройки пользовательской информациии открывается после Регистрации.
    
    var reference: DatabaseReference!
    
    let transtion = TransitionClass()
    var topView: UIView?
    
    let arrayForYears: [Int] = {
        var array = [Int]()
        var firstYear = 1969
        var count = 0
        for _ in 0..<50 {
            array.append(firstYear)
            firstYear += 1
            count += 1
        }
        return array
    }()
    
    let arrayForMonth = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    
    let arrayForDays: [Int] = {
        var array = [Int]()
        var firstDay = 1
        var count = 0
        for _ in 0..<31 {
            array.append(firstDay)
            firstDay += 1
            count += 1
        }
        return array
    }()
    
    let arrayOfCountries: [String] = {
        var array = [String]()
        for (key, _) in Sources.shared.countriesAndCities {
            array.append(key)
        }
        return array
    }()
    
    var arrayOfCities: [String] = []
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var secondNameTF: UITextField!
    @IBOutlet weak var phoneNumberTF: UITextField!
    
    @IBOutlet weak var dateOfBirthButtonOutlet: UIButton!
    @IBOutlet weak var countryButtonOutlet: UIButton!
    @IBOutlet weak var cityButtonOutlet: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTF.delegate = self
        secondNameTF.delegate = self
        phoneNumberTF.delegate = self
        reference = Database.database().reference()
    }
    
    func callAlertIf() {
        let alert = UIAlertController(title: "Provide correct information", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .destructive, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func dateOfBirthButton(_ sender: Any) {
        actionPickerOne()
    }
    @IBAction func countryButton(_ sender: Any) {
        actionPickerTwo()
    }
    @IBAction func cityButton(_ sender: Any) {
        actionPickerThree()
    }
    
    @IBAction func applyButton(_ sender: Any) {
        writeDataToDB()
    }
    
}
