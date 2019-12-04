//
//  SettingViewController.swift
//  After Next Player
//
//  Created by mohamed hisham on 11/7/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tableView: IntrinsicTableView!
    let fields:[String] = ["Edit My account","contact us","Complaints & Suggestions","Help","Logout"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}
extension SettingViewController:UITableViewDelegate,UITableViewDataSource{
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = fields[indexPath.row]
        return cell
      }
      
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 4 ){
            print("here")
            self.navigationController?.modalPresentationStyle = .fullScreen
           
            let vc = RegViewController()
             vc.isModalInPresentation = true
            self.navigationController?.present(vc, animated: true, completion: {
              UserDefaults.standard.set(false, forKey: "set")
            })
        }
        if indexPath.row == 2 {
            let vc = ComplainsViewController()
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
        if indexPath.row == 3 {
            let vc = FAAViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if (indexPath.row == 1){
            let vc = ContactViewController()
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
        if (indexPath.row == 0 ){
                  print("here")
                  let vc = RegViewController()
                  self.navigationController?.present(vc, animated: true, completion: {
                            vc.mobileTextField.text = UserDefaults.standard.string(forKey: "mobile")
                    vc.nameTextField.text = UserDefaults.standard.string(forKey: "name")
                        vc.startButton.setTitle("Edit", for: .normal)})
              }
    }
  }
