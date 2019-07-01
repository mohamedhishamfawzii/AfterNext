//
//  ArenasViewController.swift
//  After Next Player
//
//  Created by mahmoud mohamed on 6/24/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import Firebase

class ArenasViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var arenaSearchBar: UISearchBar!
    @IBOutlet weak var arenasCollectionView: UICollectionView!
    let collectionViewCellNib = UINib(nibName: "ArenasCollectionViewCell", bundle: nil)
    let collectionViewCellReuseId = "ArenasCollectionViewCell"
    var hoursArray=[Bool](repeatElement(false,count: 8))
    var arenas:[Arena] = []
     let times = ["6 PM","7 PM","8 PM","9 PM","10 PM","11 PM","12 AM","1 AM"]
     var collectionRef:CollectionReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    override func viewWillAppear(_ animated: Bool) {
        getArenas()
    }
    func config(){
        let v = arenaSearchBar.subviews.first!.subviews[0]
        v.removeFromSuperview()
        let textField = arenaSearchBar.value(forKey: "searchField") as! UITextField
        textField.borderStyle = .none
        searchView.layer.shadowRadius = 0.3
        searchView.layer.shadowColor = UIColor(red: 229/255, green: 236/255, blue: 237/255, alpha: 1).cgColor
        searchView.layer.shadowOpacity = 1
        searchView.layer.shadowOffset = CGSize(width: 1, height: 3.5)
        searchView.layer.borderWidth = 0.25
        searchView.layer.borderColor=UIColor.gray.cgColor
        configCollectionView()
        collectionRef = Firestore.firestore().collection("Arenas")
    }
    
    func getArenas() {
        collectionRef.getDocuments{ (snapshot,err) in
            if let err=err{
                print(err)
            }else{
                for document in snapshot!.documents{
                    let arenaData = document.data()
                    let name = arenaData["Name"] as? String ?? "blank"
                    let location = arenaData["location"] as? String ?? "blank"
                    let price = arenaData["price"] as? String ?? "blank"
                    let hours = arenaData["TodayHours"] as? [Bool] ??
                        [Bool](repeatElement(false,count: 8))
                      let number = arenaData["arenaPhone"] as? String ?? "blank"
                    let newArena = Arena(name:name,location: location,price: price,hours: hours, number: number)
                    let arenaCompare = self.arenas.filter({$0 as Arena == newArena}).count > 0
                    print(arenaCompare)
                    if (arenaCompare){print("already added")}else{
                        self.arenas.append(newArena)
                    }}
                self.arenasCollectionView.reloadData()
                
            }
        }
    }
    
    func configCollectionView(){
        self.arenasCollectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: collectionViewCellReuseId)
    }
    
}

extension ArenasViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arenas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellReuseId, for: indexPath) as! ArenasCollectionViewCell
        cell.nameLabel.text = arenas[indexPath.row].name
        cell.locationLabel.text = arenas[indexPath.row].location
        cell.priceLabel.text = String(arenas[indexPath.row].price)
        cell.index=indexPath
        cell.delegate=self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 250)
    }
    
}
extension ArenasViewController:ArenaBookedProtocol{
    func arenaBooked(index: Int , time:Int) {
        let bookedArena = arenas[index]
        hoursArray=bookedArena.hours
        print(bookedArena.hours)
        let newbooking=Booking(arena: bookedArena.name , location: bookedArena.location, hour: times[time], arenaNumber: bookedArena.number)
        if (bookedArena.hours[time]==false){
            hoursArray[time]=true
            Firestore.firestore().collection("Arenas")
                .whereField("Name", isEqualTo: bookedArena.name)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        
                    } else if querySnapshot!.documents.count != 1 {
                        // Perhaps this is an error for you?
                    } else {
                        let document = querySnapshot!.documents.first
                        document!.reference.updateData([
                            "TodayHours": self.hoursArray
                            ])
                        bookedArena.hours=self.hoursArray
                        
                        Firestore.firestore().collection("Bookings").addDocument(data: ["arenaName":newbooking.arenaName,"playerName":newbooking.playerName,"playerMobile":newbooking.playerMobile,"status":newbooking.status,"approved":newbooking.approved,"played":newbooking.played,"notes":newbooking.notes,"arenaLocation":newbooking.arenaLocation,"time":newbooking.hour]) {
                            
                            (err)in
                            if let err = err{
                                print(err)
                            }
                            else{
                                let alert = UIAlertController(title: "Your booking request has been recorded", message: "you can check the booking status from all bookings tab", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                    NSLog("The \"OK\" alert occured.")
                                }))
                                self.present(alert, animated: true, completion: nil)
                                
                                
                                
                                
                            }
                        }
                    }
            }}else
        {
            let alert = UIAlertController(title: "This Hour is already booked", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
}
