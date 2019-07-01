//
//  AdminScanViewController.swift
//  After Next Admin
//
//  Created by mohamed hisham on 6/24/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import Firebase
class AdminScanViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    var bookings:[Booking]=[]
    var vc :DetailViewController!
    var collectionRef:CollectionReference!
    var bookingNib = UINib(nibName: "BookingsTableViewCell", bundle: nil)
    var bookingReuse = "BookingsTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForPreviewing(with: self, sourceView: tableView)
config()
        tableView.register(bookingNib, forCellReuseIdentifier:bookingReuse)
        self.tableView.separatorStyle = .none
        self.tableView.bounces=false
       
       
    }
    override func viewWillAppear(_ animated: Bool) {
      getBookings()
    }
    func getBookings() {
        collectionRef.getDocuments{ (snapshot,err) in
            if let err=err{
                print(err)
            }else{
                for document in snapshot!.documents{
                    let bookingData = document.data()
                    let name = bookingData["arenaName"] as? String ?? "blank"
                    print(name)
                    let location = bookingData["arenaLocation"] as? String ?? "blank"
                    let playerName = bookingData["playerName"] as? String ?? "blank"
                    let playerMobile=bookingData["playerMobile"] as? String ?? "blank"
                    let booking = Booking(arena: name,location: location,hour:bookingData["time"] as? String ?? "blank", arenaNumber: bookingData["arenaNumber"] as? String ?? "blank", playerName: playerName , playerNumber: playerMobile,id:document.documentID)
       
                   self.bookings.append(booking)
                }
                self.tableView.reloadData()
                
            }
        }
    }


    func config(){
        
        let v = locationSearchBar.subviews.first!.subviews[0]
        v.removeFromSuperview()
        let textField = locationSearchBar.value(forKey: "searchField") as! UITextField
        textField.borderStyle = .none
        searchView.layer.shadowRadius = 0.3
        searchView.layer.shadowColor = UIColor(red: 229/255, green: 236/255, blue: 237/255, alpha: 1).cgColor
        searchView.layer.shadowOpacity = 1
        searchView.layer.shadowOffset = CGSize(width: 1, height: 3.5)
        searchView.layer.borderWidth = 0.25
        searchView.layer.borderColor=UIColor.gray.cgColor
        collectionRef = Firestore.firestore().collection("Bookings")
        
    }

}

extension AdminScanViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell = (tableView.dequeueReusableCell(withIdentifier: bookingReuse) as? BookingsTableViewCell)!
        currentCell.arenaLabel.text = bookings[indexPath.row].arenaName
        currentCell.locationLabel.text = bookings[indexPath.row].arenaLocation
          currentCell.time.text = bookings[indexPath.row].hour
        currentCell.index=indexPath.row
        currentCell.delegate=self
        return currentCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let  vc=DetailViewController(nibName: "DetailViewController", bundle: nil)
          vc.name=bookings[indexPath.row].playerName
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension AdminScanViewController:bookingProtocol{
    func acceptClicked(index: Int) {
        print(index)
        print("accepted")
        print(bookings[index].id)
        collectionRef.getDocuments{ (querySnapshot,err) in
            if let err=err{
                print(err)
            }else{
                for document in querySnapshot!.documents{
                    if (document.documentID == self.bookings[index].id){
                        document.reference.updateData([
                            "status": "approved"
                            ])
                    }
            
                }
          
            }
        }
      
    }
    
   
    func declineClicked(index: Int) {
        print(index)
        print("declined")
               print(bookings[index].id)
        collectionRef.getDocuments{ (querySnapshot,err) in
            if let err=err{
                print(err)
            }else{
                for document in querySnapshot!.documents{
                    if (document.documentID == self.bookings[index].id){
                        document.reference.updateData([
                            "status": "declined"
                            ])
                    }
                    
                }
                
            }
        }
}
    
    
    
}
extension AdminScanViewController:UIViewControllerPreviewingDelegate{
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = tableView.indexPathForRow(at: location) {
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
         let vc=DetailViewController(nibName: "DetailViewController", bundle: nil)
            vc.name=bookings[indexPath.row].playerName
            return vc
        }
        
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}
