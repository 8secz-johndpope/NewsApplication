//
//  ExtensionForProfileMethods.swift
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



extension ProfilePageViewController: UITextFieldDelegate {
    
    //MARK: Выбрать дату рождения
    func getBirthDate(day: Int, month: Int, year: Int) {
        dateOfBirthButtonOutlet.setTitle("\(day).\(month).\(year)", for: .normal)
    }
    //MARK: Выбрать страну
    func getCountry(country: String) {
        countryButtonOutlet.setTitle("\(country)", for: .normal)
    }
    //MARK: Выбрать город
    func getCity(country: String) {
        cityButtonOutlet.setTitle("\(country)", for: .normal)
    }
    
    
    //MARK: Настройка Select Box для даты
    func actionPickerOne() {
        ActionSheetMultipleStringPicker.show(withTitle: "Select date of birth", rows: [
            self.arrayForDays, self.arrayForMonth, self.arrayForYears], initialSelection: [0, 0, 0], doneBlock: {
                picker, indexes, values in
                guard let indexes = indexes else {return}
                var newArray: [Int] = []
                for i in indexes {
                    newArray.append(i as! Int)
                }
                self.getBirthDate(day: self.arrayForDays[newArray[0]], month: self.arrayForMonth[newArray[1]], year: self.arrayForYears[newArray[2]])
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: self.view)
    }
    
    
    //MARK: Настройка Select Box для страны
    func actionPickerTwo() {
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
    
    
    //MARK: Настройка Select Box для города
    func actionPickerThree() {
        arrayOfCities.removeAll()
        for (key, value) in Sources.shared.countriesAndCities {
            if key == countryButtonOutlet.titleLabel?.text {
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)        
        return true
    }
}
