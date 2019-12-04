//
//  RegViewController.swift
//  After Next Player
//
//  Created by mohamed hisham on 6/30/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import Firebase
class RegViewController: UIViewController {
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    var collectionRef:CollectionReference!
    @IBOutlet weak var mobileTextField: UITextField!
    var locations : [String] = [String]()
    var selectedLocation = 0 
    override func viewWillAppear(_ animated: Bool) {
        let collectionRefb = Firestore.firestore().collection("Location")
                     collectionRefb.getDocuments{ [weak self] (snapshot,err) in
                         if let err=err{
                             print(err)
                         }else{
                             for document in snapshot!.documents{
                               let location = document.data()
                               print(location["name"])
                               self?.locations.append(location["name"] as! String)
                         }
                            Manager.areas = self?.locations ?? [String]()
                           self?.pickerView.reloadAllComponents()
                     }
               }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKey))
        view.addGestureRecognizer(tap)
        pickerView.delegate = self
        pickerView.dataSource = self
        // Do any additional setup after loading the view.
       }
    @objc func dismissKey(){
        view.endEditing(true)
    }

    @IBAction func startPressed(_ sender: Any) {
        
        if ( mobileTextField.text != "" && nameTextField.text != ""){
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        UserDefaults.standard.set(mobileTextField.text, forKey: "mobile")
            UserDefaults.standard.set(locations[selectedLocation], forKey: "location")
         UserDefaults.standard.set(true, forKey: "set")
        let sb = UIStoryboard(name:"Main", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "nav")
        let vcc = PlayerHomeView()
        vc.addChild(vcc)
        self.present(vc, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Enter your data", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension RegViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locations.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
    return locations[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print (row)
        selectedLocation=row
    }
    
    
}
