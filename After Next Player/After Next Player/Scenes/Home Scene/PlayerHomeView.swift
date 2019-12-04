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
    
    @IBOutlet weak var bookingsTableView: IntrinsicTableView!
    let times = ["6 PM","7 PM","8 PM","9 PM","10 PM","11 PM","12 AM","1 AM"]
    let loading: ProgressHUD = ProgressHUD(text: "Loading...")

    @IBOutlet var seeAllButtons: [UIButton]!
    @IBOutlet weak var arenasCollectionView: UICollectionView!
    var bookings:[Booking]=[]
    var myBookings:[Booking]=[]
    var collectionRef:CollectionReference!
    var collectionRefB:CollectionReference!
    let tableViewCellNib = UINib(nibName: "BookingsTableViewCell", bundle: nil)
    let errorCellNib = UINib(nibName: "NoBookingsTableViewCell", bundle: nil)
    let tableViewCellReuseId = "BookingsTableViewCell"
    let collectionViewCellNib = UINib(nibName: "ArenasCollectionViewCell", bundle: nil)
    let collectionViewCellReuseId = "ArenasCollectionViewCell"
    var arenas:[Arena] = []
     var arenasNearYou:[Arena] = []
    var hoursArray=[Bool](repeatElement(false,count: 8))
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        Firestore.firestore().collection("Bookings").whereField("status", isEqualTo: "approved")
            .addSnapshotListener { querySnapshot, error in
                //                self.bookings.removeAll()
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.bookingsTableView.reloadData()
                let Bookings = documents.map { $0["status"] }
                print("Current cities in CA: \(Bookings)")
        }
        Firestore.firestore().collection("Bookings")
            .addSnapshotListener { querySnapshot, error in
                self.bookings.removeAll()
                if let error = error {
                    print("Error retreiving collection: \(error)")
                }
                self.getBookings()
                self.bookingsTableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        getArenas()
        getBookings()
        self.view.addSubview(loading)
    }
    func getBookings() {
        let collectionRefb = Firestore.firestore().collection("Bookings")
        collectionRefb.getDocuments{ [weak self] (snapshot,err) in
            if let err=err{
                print(err)
            }else{
                for document in snapshot!.documents{
                    let bookingData = document.data()
                    let name = bookingData["arenaName"] as? String ?? "blank"
                    print(name)
                    let location = bookingData["arenaLocation"] as? String ?? "blank"
                    let playerName = bookingData["playerName"] as? String ?? "blank"
                    let playerNumber = bookingData["playerMobile"] as? String ?? "blank"
                    let booking = Booking(arena: name,location: location,hour:bookingData["time"] as? String ?? "blank", arenaNumber: bookingData["arenaNumber"] as? String ?? "blank",playerName: playerName,playerNumber: playerNumber)
                    booking.status=bookingData["status"] as? String ?? "waiting"
                    let bookingCompare = (self?.bookings.filter({$0 as Booking == booking}).count)! > 0
                    print(bookingCompare)
                    if (bookingCompare){print("already added")}else{
                        self?.bookings.append(booking)
                    }}
                print(self?.bookings.count)
                self?.myBookings=(self?.bookings.filter({$0.playerMobile == UserDefaults.standard.string(forKey: "mobile")!}))!
                self?.myBookings =  self?.myBookings.sorted { $0.arenaName < $1.arenaName } ?? self?.myBookings ?? [Booking]()
                self?.loading.hide()
                self?.bookingsTableView.reloadData()
                
            }
        }
    }
    func getArenas() {
        arenas.removeAll()
        arenasNearYou.removeAll()
        collectionRef.getDocuments{ [weak self](snapshot,err) in
            if let err=err{
                print(err)
            }else{
                for document in snapshot!.documents{
                    let arenaData = document.data()
                    let name = arenaData["Name"] as? String ?? "blank"
                    let location = arenaData["location"] as? String ?? "blank"
                    let price = arenaData["price"] as? String ?? "blank"
                    let hours = arenaData["TodayHours"] as? [Bool] ?? [Bool](repeatElement(false,count: 8))
                    let number = arenaData["arenaPhone"] as? String ?? "blank"
                    let id = document.documentID
                    print("id",id)
                    let newArena = Arena(name:name,location: location,price: price,hours: hours, number: number )
                    print(newArena.name)
                    
                    let arenaCompare = (self?.arenas.filter({$0 as Arena == newArena}).count)! > 0
                    print(arenaCompare)
                    if (arenaCompare){print("already added")}else{
                        self?.arenas.append(newArena)
                    }
                }
                self?.arenasNearYou = (self?.arenas.filter({ (arena) -> Bool in
                    arena.location.contains(UserDefaults.standard.string(forKey: "location")!)
                }))!
                self?.arenasCollectionView.reloadData()
                
            }
        }
    }
    
    func config(){
    
        ConfigBookingsTableView()
        configCollectionView()
        collectionRef = Firestore.firestore().collection("Arenas")
        collectionRefB = Firestore.firestore().collection("Bookings")
      
    }
    
    func setupSearchBar() {
     
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func ConfigBookingsTableView(){
        bookingsTableView.register(tableViewCellNib, forCellReuseIdentifier: tableViewCellReuseId)
            bookingsTableView.register(errorCellNib, forCellReuseIdentifier: "NoBookingsTableViewCell")
    }
    
    func configCollectionView(){
        arenasCollectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: collectionViewCellReuseId)
    }
    
    
    @IBAction func settingsTapped(_ sender: Any) {
        let vc = SettingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func seeAllArenasTapped(_ sender: Any) {
        let allArenasVC = ArenasViewController()
        allArenasVC.arenas = self.arenas
        self.navigationController?.pushViewController(allArenasVC, animated: true)
    
        print("hma")
    }
}

extension PlayerHomeView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (myBookings.count == 0){
            return 1
        }else{
            return myBookings.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (myBookings.count == 0){
            let currentCell = (tableView.dequeueReusableCell(withIdentifier: "NoBookingsTableViewCell") as? NoBookingsTableViewCell)!
            currentCell.isSelected=true
            return currentCell
            }else{
        let currentCell = (tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseId) as? BookingsTableViewCell)!
        currentCell.arenaName.text = myBookings[indexPath.row].arenaName
        currentCell.arenaLocation.text = myBookings[indexPath.row].arenaLocation
        currentCell.time.text = myBookings[indexPath.row].hour
        currentCell.status.text=myBookings[indexPath.row].status
        currentCell.status.textColor=UIColor.orange

        if (currentCell.status.text=="approved"){
            currentCell.status.textColor=UIColor.green
            currentCell.status.text = "approved"
        }
        if (currentCell.status.text=="declined"){
            currentCell.status.textColor=UIColor.red
            currentCell.status.text = "declined"

            }
              return currentCell
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (myBookings.count == 0){return 200}else{
            return 90}
    }
}

extension PlayerHomeView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arenasNearYou.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellReuseId, for: indexPath) as! ArenasCollectionViewCell
        cell.nameLabel.text = arenasNearYou[indexPath.row].name
        cell.locationLabel.text = arenasNearYou[indexPath.row].location
        cell.priceLabel.text = String(arenasNearYou[indexPath.row].price)
        cell.index=indexPath
        cell.delegate=self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: ((collectionView.frame.size.width/1.25)), height: 200)
    }
    
}
extension PlayerHomeView:ArenaBookedProtocol{
    func arenaBooked(index: Int , time:Int) {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
        loading.show()
        let bookedArena = arenasNearYou[index]
        hoursArray=bookedArena.hours
        print(bookedArena.hours)
        let newbooking=Booking(arena: bookedArena.name , location: bookedArena.location, hour:times[time], arenaNumber: bookedArena.number)
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
                        
                        Firestore.firestore().collection("Bookings").addDocument(data: ["arenaName":newbooking.arenaName,"playerName":newbooking.playerName,"playerMobile":newbooking.playerMobile,"status":newbooking.status,"approved":newbooking.approved,"played":newbooking.played,"notes":newbooking.notes,"arenaLocation":newbooking.arenaLocation,"time":newbooking.hour,"arenaPhone":newbooking.arenaNumber,"timeStamp":dateString]) {
                            
                           [weak self] (err)in
                            if let err = err{
                                print(err)
                            }
                            else{
                                self?.loading.hide()
                                let alert = UIAlertController(title: "Your booking request has been recorded", message: "you can check the booking status from all bookings tab", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                    NSLog("The \"OK\" alert occured.")
                                }))
                                self?.present(alert, animated: true, completion: nil)
                                self?.getBookings()
                            }
                        }
                    }
            }}else
        {
            self.loading.hide()
            let alert = UIAlertController(title: "This Hour is already booked", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
