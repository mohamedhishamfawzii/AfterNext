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
    var bookings:[Booking] = [Booking]()
    
    var collectionRef:CollectionReference!
    var bookingNib = UINib(nibName: "BookingsTableViewCell", bundle: nil)
    var bookingReuse = "BookingsTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        tableView.register(bookingNib, forCellReuseIdentifier:bookingReuse)
        self.tableView.separatorStyle = .none
        self.tableView.bounces=false
        Firestore.firestore().collection("Bookings")
            .addSnapshotListener { [weak self] querySnapshot, error in
                if let error = error {
                    print("Error retreiving collection: \(error)")
                }
                self?.getBookings()
                self?.tableView.reloadData()
        }
    }
    
    
    func getBookings() {
        bookings = [Booking]()
        collectionRef.getDocuments{ [weak self] (snapshot,err) in
            if let err=err{
                print(err)
            }else{
                for document in snapshot!.documents{
                    let bookingData = document.data()
                    if ((bookingData["status"] as? String ) == "Waiting Approval" || (bookingData["status"] as? String ) == "waiting for approval" ){
                    let name = bookingData["arenaName"] as? String ?? "blank"
                    print(name)
                    let location = bookingData["arenaLocation"] as? String ?? "blank"
                    let booking = Booking(arena: name,location: location,hour:bookingData["time"] as? String ?? "blank", arenaNumber: bookingData["arenaPhone"] as? String ?? "blank",playerNumber:bookingData["playerMobile"] as? String ?? "blank", playerName:bookingData["playerName"] as? String ?? "hisham",timeStamp: bookingData["timeStamp"]as? String ?? "couldn't get time" )
                    booking.id = document.documentID
                        var added = false
                        for bookingg in self?.bookings ?? [Booking]() {
                            if bookingg.id == booking.id{
                                added = true
                            }
                        }
                        if !added{
                            self?.bookings.append(booking)}
                    }}
                
                 self?.bookings =  self?.bookings.sorted { $0.arenaName < $1.arenaName } ?? self?.bookings ?? [Booking]()
                
                self?.tableView.reloadData()
                
            }
        }
    }
    
    
    func config(){
    
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
        currentCell.stamp.text = bookings[indexPath.row].timeStamp
        currentCell.index=indexPath.row
        currentCell.delegate=self
        return currentCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: bookings[indexPath.row].playerName, message: ("Player:"+bookings[indexPath.row].playerMobile + "                     Arena :"+bookings[indexPath.row].arenaNumber), preferredStyle: .alert)
                             alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                 NSLog("The \"OK\" alert occured.")
                             }))
                             self.present(alert, animated: true, completion: nil)
    }
}

extension AdminScanViewController:bookingProtocol{
    func acceptClicked(index: Int) {
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
                        let alert = UIAlertController(title: "Done", message: "Booking Approved", preferredStyle: .alert)
                                             alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                                 NSLog("The \"OK\" alert occured.")
                                             }))
                                             self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                
            }
        }
        
    }
    
    
    func declineClicked(index: Int) {
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
                        
                        let alert = UIAlertController(title: "Done", message: "Booking Declined", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                            NSLog("The \"OK\" alert occured.")
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                }
                
            }
        }
    }
}
