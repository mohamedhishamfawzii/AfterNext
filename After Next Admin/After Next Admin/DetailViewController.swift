//
//  DetailViewController.swift
//  After Next Admin
//
//  Created by mohamed hisham on 7/1/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var playerNubmer: UILabel!
    @IBOutlet weak var playerName: UILabel!
    var name:String!
    var mobile:String!
    override func viewDidLoad() {
        super.viewDidLoad()
       playerName.text=name
        playerNubmer.text=mobile
        

        // Do any additional setup after loading the view.
    }
    

  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
