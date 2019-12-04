//
//  ComplainsViewController.swift
//  After Next Player
//
//  Created by mohamed hisham on 11/9/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class ComplainsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
    }


    @IBAction func sendClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Thanks for your feedback", message:"", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            self.dismiss(animated: true, completion: nil)
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
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
