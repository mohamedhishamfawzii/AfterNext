//
//  AddArenasViewController.swift
//  After Next Admin
//
//  Created by mohamed hisham on 6/24/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class AddArenasViewController: UIViewController {

    @IBOutlet weak var fieldsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fieldsView.layer.shadowRadius = 0.3
        fieldsView.layer.shadowColor = UIColor(red: 229/255, green: 236/255, blue: 237/255, alpha: 1).cgColor
        fieldsView.layer.shadowOpacity = 1
        fieldsView.layer.cornerRadius=5
        fieldsView.layer.shadowOffset = CGSize(width: 1, height: 3.0)
        fieldsView.layer.borderWidth = 0.25
        fieldsView.layer.borderColor=UIColor.gray.cgColor
        // Do any additional setup after loading the view.
    }

    @IBAction func addClicked(_ sender: Any) {
        print("add clicked")
    }
    
 
     @IBAction func finishPressed(_ sender: Any) {
         print("finish clicked")
     }
    

}
