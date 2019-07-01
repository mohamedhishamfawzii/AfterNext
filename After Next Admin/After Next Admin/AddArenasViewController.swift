//
//  AddArenasViewController.swift
//  After Next Admin
//
//  Created by mohamed hisham on 6/24/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import Firebase
class AddArenasViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var arenaPhone: UITextField!
    @IBOutlet weak var priceTextfield: UITextField!
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
        let location = locationTextField.text
        let arena = Arena(name: nameTextField.text!,location: location!,price: priceTextfield.text!,number: arenaPhone.text!)
        Firestore.firestore().collection("Arenas").addDocument(data: ["Name":arena.name,"location":location!,"price":arena.price,"Rating":2,"TodayHours":arena.hours,"arenaPhone":arena.number]) {
            
            (err)in
            if let err = err{
                print(err)
            }
            else{
                let alert = UIAlertController(title: "Added Successfully", message: "Your Arena has been added , you can add another Arena", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
                self.priceTextfield.text=""
                self.nameTextField.text=""
                
                
                
            }
        }
    }
    
 
     @IBAction func finishPressed(_ sender: Any) {
         print("finish clicked")
        let scanVC = AdminScanViewController()
        self.navigationController?.pushViewController(scanVC, animated: true)
     }
    

}

    
    
    

