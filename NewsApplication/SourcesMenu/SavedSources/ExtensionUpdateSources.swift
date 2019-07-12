//
//  ExtensionUpdateSources.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/12/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

extension SavedSourcesController {
    func updateSources() {
        let sources: [String: String] = {
            var sources = [String:String]()
            for i in 0..<UserData.shared.subsId.count {
                sources[UserData.shared.subs[i]] = UserData.shared.subsId[i]
            }
            return sources
        }()
        
        reference.child("UsersDB").child("\(UserData.shared.email)").child("subs").setValue(sources) { (error, refer) in
            if error == nil {
                print("sources updated successfully")
                print(sources)
            } else {
                print(" failed to save to UsersDB")
            }
        }
    }
}
