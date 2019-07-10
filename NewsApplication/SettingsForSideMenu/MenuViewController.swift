//
//  MenuViewController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/10/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

enum MenuType: Int {
    case news
    case links
    case weather
    case profile
    case logout
}

class MenuViewController: UITableViewController {
    
    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menu = MenuType(rawValue: indexPath.row) else {return }
        dismiss(animated: true) { [weak self] in 
            self?.didTapMenuType?(menu)
        }
    }

}
