//
//  FilterViewController.swift
//  After Next Player
//
//  Created by mohamed hisham on 11/6/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import Firebase
class FilterViewController: UIViewController {
    @IBOutlet weak var pickerView: UIPickerView!
    var selectedLocation:Int = 0
    var  vc :Filterable!
    var arenas :[Arena] = [Arena]()
    var locations:[String]=[String]()
    @IBOutlet weak var myView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.layer.cornerRadius = 20
        pickerView.delegate = self
        pickerView.dataSource = self
        // Do any additional setup after loading the view.
    }
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

    @IBAction func doneClicked(_ sender: Any) {
  
        let filteredArenas=self.arenas.filter({ (arena) -> Bool in arena.location.contains(Manager.areas[selectedLocation])
        })
        vc.filter(arenas: filteredArenas)
        
        self.dismiss(animated: true, completion: nil)
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


extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.locations.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return self.locations[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print (row)
        selectedLocation=row
    }
    
    
}
