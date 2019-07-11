//
//  ExtensionForWeatherVC.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.dateLbl.text = self.weatherDate[indexPath.row]
        cell.minLbl.text = self.weatherTempMin[indexPath.row]
        cell.maxLbl.text = self.weatherTempMax[indexPath.row]
        cell.mainLbl.text = self.weatherMain[indexPath.row]
        return cell
    }
    
    
}