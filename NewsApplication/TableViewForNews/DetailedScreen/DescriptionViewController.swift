//
//  DescriptionViewController.swift
//  NewsApplication
//
//  Created by Vladyslav on 7/10/19.
//  Copyright © 2019 Vladyslav. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var titleLbl: String = ""
    var descriptionTV: String = ""
    var imageviewLink: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleLbl
        descriptionTextView.text = descriptionTV
        
        
        guard let url = URL(string: imageviewLink) else {return}
        let data2 = try? Data(contentsOf: url)
        
        if let imageData = data2 {
            imageView.image = UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal)
        }
       
    }


}

