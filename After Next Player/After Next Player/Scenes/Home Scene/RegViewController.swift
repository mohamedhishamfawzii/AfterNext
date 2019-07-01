//
//  RegViewController.swift
//  After Next Player
//
//  Created by mohamed hisham on 6/30/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class RegViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func startPressed(_ sender: Any) {
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        UserDefaults.standard.set(mobileTextField.text, forKey: "mobile")
         UserDefaults.standard.set(true, forKey: "set")
        let sb = UIStoryboard(name:"Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "nav")
        let vcc = PlayerHomeView()
        vc.addChild(vcc)
        self.present(vc, animated: true, completion: nil)
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
