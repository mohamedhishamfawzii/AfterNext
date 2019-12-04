//
//  ArenasViewController.swift
//  After Next Player
//
//  Created by mahmoud mohamed on 6/24/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import Firebase

protocol Filterable {
   func filter(arenas:[Arena])
}
class ArenasViewController: UIViewController,Filterable{
     let errorCellNib = UINib(nibName: "ErrorCollectionViewCell", bundle: nil)
    func filter(arenas: [Arena]) {
        
        self.arenas = arenas
    self.arenasCollectionView.reloadData()
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        return searchController
    }()
    @IBOutlet weak var arenasCollectionView: UICollectionView!
    let collectionViewCellNib = UINib(nibName: "ArenasCollectionViewCell", bundle: nil)
    let collectionViewCellReuseId = "ArenasCollectionViewCell"
    var hoursArray=[Bool](repeatElement(false,count: 8))
   var arenas:[Arena] = []
    var allArenas:[Arena] = []
     let times = ["6 PM","7 PM","8 PM","9 PM","10 PM","11 PM","12 AM","1 AM"]
     var collectionRef:CollectionReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    override func viewWillAppear(_ animated: Bool) {
      //  getArenas()
        print(arenas)
        self.allArenas = arenas
        
    }
    func config(){
        configCollectionView()
        collectionRef = Firestore.firestore().collection("Arenas")
        setupSearchBar()
    }
    
    
    @IBAction func cancelCalled(_ sender: Any) {
        self.arenas = allArenas
        self.arenasCollectionView.reloadData()
    }
    @IBAction func filterClicked(_ sender: Any) {
        let vc = FilterViewController()
        vc.vc = self as? Filterable
        vc.arenas = allArenas
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    func setupSearchBar() {
        self.navigationItem.title = "Arenas"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        self.navigationItem.searchController?.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController?.searchBar.delegate = self as UISearchBarDelegate
        self.navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
    func getArenas() {
        collectionRef.getDocuments{ [weak self] (snapshot,err) in
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
                    let arenaCompare = self!.arenas.filter({$0 as Arena == newArena}).count > 0
                    print(arenaCompare)
                    if (arenaCompare){print("already added")}else{
                        self!.arenas.append(newArena)
                    }}
                self!.arenasCollectionView.reloadData()
                self!.allArenas = self!.arenas
                
                
            }
        }
    }
    
    func configCollectionView(){
             self.arenasCollectionView.register(errorCellNib, forCellWithReuseIdentifier: "ErrorCollectionViewCell")
        self.arenasCollectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: collectionViewCellReuseId)
    }
    
}

extension ArenasViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if arenas.count == 0{
            return 1
        }else{
            return arenas.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if arenas.count == 0{
            let currentCell = (arenasCollectionView.dequeueReusableCell(withReuseIdentifier: "ErrorCollectionViewCell", for: indexPath) as? ErrorCollectionViewCell)!
                             currentCell.isSelected=true
                             return currentCell
               }else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellReuseId, for: indexPath) as! ArenasCollectionViewCell
        cell.nameLabel.text = arenas[indexPath.row].name
        cell.locationLabel.text = arenas[indexPath.row].location
        cell.priceLabel.text = String(arenas[indexPath.row].price)
        cell.index=indexPath
        cell.delegate=self
            return cell}
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 200)
    }
    
}
extension ArenasViewController:ArenaBookedProtocol{
    func arenaBooked(index: Int , time:Int) {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let dateString = formatter.string(from: now)
        let bookedArena = arenas[index]
        hoursArray=bookedArena.hours
        print(bookedArena.hours)
        let newbooking=Booking(arena: bookedArena.name , location: bookedArena.location, hour: times[time], arenaNumber: bookedArena.number)
        if (bookedArena.hours[time]==false){
            hoursArray[time]=true
            Firestore.firestore().collection("Arenas")
                .whereField("Name", isEqualTo: bookedArena.name)
                .getDocuments() { [weak self](querySnapshot, err) in
                    if err != nil {
                        
                    } else if querySnapshot!.documents.count != 1 {
                        // Perhaps this is an error for you?
                    } else {
                        let document = querySnapshot!.documents.first
                        document!.reference.updateData([
                            "TodayHours": self?.hoursArray
                            ])
                        bookedArena.hours=self?.hoursArray ?? [Bool]()
                        
                        Firestore.firestore().collection("Bookings").addDocument(data: ["arenaName":newbooking.arenaName,"playerName":newbooking.playerName,"playerMobile":newbooking.playerMobile,"status":newbooking.status,"approved":newbooking.approved,"played":newbooking.played,"notes":newbooking.notes,"arenaLocation":newbooking.arenaLocation,"time":newbooking.hour,"timeStamp":dateString]) {
                            
                            (err)in
                            if let err = err{
                                print(err)
                            }
                            else{
                                let alert = UIAlertController(title: "Your booking request has been recorded", message: "you can check the booking status from all bookings tab", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                                    NSLog("The \"OK\" alert occured.")
                                }))
                                self?.present(alert, animated: true, completion: nil)
                                
                                
                                
                                
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


extension ArenasViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let _ = searchController.searchBar.text {
            
        }
    }
}

extension ArenasViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if searchBar.text?.isEmpty ?? true , text == "" {
            return false
        }else {
            print("text",text)
            NSObject.cancelPreviousPerformRequests(
                withTarget: self,
                selector: #selector(self.getHintsFromTextField),
                object: searchBar)
            self.perform(
                #selector(self.getHintsFromTextField),
                with: searchBar,
                afterDelay: 0.6)
            return true
        }
    }
    
    @objc private func getHintsFromTextField(searchBar: UISearchBar) {
        _ = searchBar.text!
        /// if the user deleted all the text in search bar
        if searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
            //            presenter.searchbarBecomeEmpty()
            //            handleResultView(emptySearchText: true)
            
        }else if searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            arenas=allArenas
            self.arenasCollectionView.reloadData()
            arenas = arenas.filter {
                
                let title = $0.name
                return   (title.lowercased().contains(searchBar.text!.lowercased())) }
            print("match",searchBar.text ?? "")
            
            
        }
          print(arenas.count)
        self.arenasCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
            arenas=allArenas
            self.arenasCollectionView.reloadData()
        
        arenas = arenas.filter {
            
            let title = $0.location
            return   (title.lowercased().contains(searchBar.text!.lowercased())) }
        
        print(arenas.count)
        print("match",searchBar.text ?? "")
        

    self.arenasCollectionView.reloadData()

        }
        
    
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
        
        arenas=allArenas
        self.arenasCollectionView.reloadData()
        //        handleResultView(emptySearchText: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //        handleResultView(emptySearchText: true)
        arenas=allArenas
        self.arenasCollectionView.reloadData()
    }
}
