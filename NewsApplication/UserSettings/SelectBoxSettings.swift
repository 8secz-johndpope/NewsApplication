//
//  SelectBoxSettings.swift
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


extension ProfileSettingsPage {
    
    //MARK: Select Box для страны
    func getCountry(country: String) {
        countryOutlet.setTitle("\(country)", for: .normal)
    }
    //MARK: Select Box для города
    func getCity(country: String) {
        cityOutlet.setTitle("\(country)", for: .normal)
    }
    
    //MARK: Настройки Select Box
    func actionPickerOne() {
        ActionSheetMultipleStringPicker.show(withTitle: "Select country", rows: [
            self.arrayOfCountries], initialSelection: [0], doneBlock: {
                picker, indexes, values in
                guard let indexes = indexes else {return}
                var newArray: [Int] = []
                for i in indexes {
                    newArray.append(i as! Int)
                }
                self.getCountry(country: self.arrayOfCountries[newArray[0]])
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
    
    func actionPickerTwo() {
        arrayOfCities.removeAll()
        for (key, value) in Sources.shared.countriesAndCities {
            if key == countryOutlet.titleLabel?.text {
                for i in value {
                    arrayOfCities.append(i)
                }
            }
        }
        ActionSheetMultipleStringPicker.show(withTitle: "Select city", rows: [
            self.arrayOfCities], initialSelection: [0], doneBlock: {
                picker, indexes, values in
                guard let indexes = indexes else {return}
                var newArray: [Int] = []
                for i in indexes {
                    newArray.append(i as! Int)
                }
                self.getCity(country: self.arrayOfCities[newArray[0]])
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
}
