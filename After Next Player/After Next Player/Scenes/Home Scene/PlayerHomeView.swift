//
//  PlayerHomeView.swift
//  After Next Player
//
//  Created by mahmoud mohamed on 6/23/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import Firebase
class PlayerHomeView: UIViewController {
    
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var bookingsTableView: UITableView!
    @IBOutlet var seeAllButtons: [UIButton]!
    @IBOutlet weak var arenasCollectionView: UICollectionView!
    var collectionRef:CollectionReference!
    let tableViewCellNib = UINib(nibName: "BookingsTableViewCell", bundle: nil)
    let tableViewCellReuseId = "BookingsTableViewCell"
    let collectionViewCellNib = UINib(nibName: "ArenasCollectionViewCell", bundle: nil)
    let collectionViewCellReuseId = "ArenasCollectionViewCell"
    var arenas:[Arena] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    override func viewWillAppear(_ animated: Bool) {
        getArenas()
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
                    let newArena = Arena(name:name,location: location,price: price)
                    self.arenas.append(newArena)
                }
                self.arenasCollectionView.reloadData()
                
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
        ConfigBookingsTableView()
        configCollectionView()
        collectionRef = Firestore.firestore().collection("Arenas")
    }
    
    
    func ConfigBookingsTableView(){
        bookingsTableView.register(tableViewCellNib, forCellReuseIdentifier: tableViewCellReuseId)
    }
    
    func configCollectionView(){
        arenasCollectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: collectionViewCellReuseId)
    }
    
    @IBAction func seeAllBookingsTapped(_ sender: Any) {
        let allBookingsVC = AllBookingsViewController()
        self.navigationController?.pushViewController(allBookingsVC, animated: true)
    }
    
    @IBAction func seeAllArenasTapped(_ sender: Any) {
        let allArenasVC = ArenasViewController()
        self.navigationController?.pushViewController(allArenasVC, animated: true)
    }
}

extension PlayerHomeView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseId, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("presssed  w")
        
    }
}

extension PlayerHomeView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: ((collectionView.frame.size.width/1.25)), height: 200)
    }
    
}
extension PlayerHomeView:ArenaBookedProtocol{
    func arenaBooked(index: Int) {
        var bookedArena = arenas[index]
        var newbooking=Booking(arena: bookedArena.name , location: bookedArena.location)
        
        Firestore.firestore().collection("Bookings").addDocument(data: ["arenaName":newbooking.arenaName,"playerName":newbooking.playerName,"playerMobile":newbooking.playerMobile,"status":newbooking.status,"approved":newbooking.approved,"played":newbooking.played,"notes":newbooking.notes,"arenaLocation":newbooking.arenaLocation]) {
            
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
    
    
}

