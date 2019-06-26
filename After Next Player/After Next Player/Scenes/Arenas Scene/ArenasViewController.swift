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
    var arenas:[Arena] = []
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
                    let newArena = Arena(name:name,location: location,price: price)
                    self.arenas.append(newArena)
                }
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 250)
    }
    
}
