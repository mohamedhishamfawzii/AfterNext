//
//  PlayerHomeView.swift
//  After Next Player
//
//  Created by mahmoud mohamed on 6/23/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class PlayerHomeView: UIViewController {
    @IBOutlet weak var locationSearchBar: UISearchBar!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var bookingsTableView: UITableView!
    @IBOutlet var seeAllButtons: [UIButton]!
    @IBOutlet weak var arenasCollectionView: UICollectionView!
    let tableViewCellNib = UINib(nibName: "BookingsTableViewCell", bundle: nil)
    let tableViewCellReuseId = "BookingsTableViewCell"
    let collectionViewCellNib = UINib(nibName: "ArenasCollectionViewCell", bundle: nil)
    let collectionViewCellReuseId = "ArenasCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
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
    
    
}

extension PlayerHomeView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellReuseId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: ((collectionView.frame.size.width/1.25)), height: 250)
    }
    
}

