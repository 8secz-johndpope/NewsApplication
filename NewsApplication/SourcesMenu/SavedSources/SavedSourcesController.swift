//
//  SavedSourcesController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/11/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SavedSourcesController: UITableViewController {
    
    //MARK: Контроллер показывает список Источников из которых берется информация. В первой секции - Сохраненные пользователем источники, во второй - источники полученные через запрос (отображает список самых популярных каналов). В первой секции можно удалять свайпом, во второй можно добавлять источник по тапу.
    
    var reference: DatabaseReference!
    let transtion = TransitionClass()
    var topView: UIView?
    
    var suggestedSourcesName: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var suggestedSourcesId: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = .white
        reference = Database.database().reference()
        self.getAPI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.updateSources()
        }
    }
    
    //MARK: Settings for TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Saved Sources"
        } else {
            return "Suggested"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return UserData.shared.subs.count
        } else {
            return suggestedSourcesName.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedSourcesCell", for: indexPath) as! SavedSourcesCell
        if indexPath.section == 0 {
        cell.sourceLabel.text = UserData.shared.subs[indexPath.row]
        return cell
        } else {
            cell.sourceLabel.text = suggestedSourcesName[indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return true
        } else { return false }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if editingStyle == .delete {
                UserData.shared.subs.remove(at: indexPath.row)
                UserData.shared.subsId.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let alert = UIAlertController(title: "Add this source to your list?", message: nil, preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Yes", style: .default) { (_) in
                var value = false
                for i in UserData.shared.subsId {
                    if i == self.suggestedSourcesId[indexPath.row] {
                        value = true
                    }
                }
                if value == false {
                UserData.shared.subsId.append(self.suggestedSourcesId[indexPath.row])
                UserData.shared.subs.append(self.suggestedSourcesName[indexPath.row])
                tableView.reloadData()
                }
            }
            let action2 = UIAlertAction(title: "No", style: .destructive, handler: nil)
            alert.addAction(action1)
            alert.addAction(action2)
            present(alert, animated: true, completion: nil)
        }
    }
}
