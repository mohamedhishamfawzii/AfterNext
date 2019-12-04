//
//  FAQViewController.swift
//  BlueBus
//
//  Created by Ahmed Osama on 7/24/19.
//  Copyright © 2019 BlueBus. All rights reserved.
//

import UIKit
import StoreKit
class FAAViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var expandedCellIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let cellID = "ExpandableTableViewCell"
        let cellNib = UINib(nibName: cellID, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = #colorLiteral(red: 0.9718735814, green: 0.9752406478, blue: 0.9813591838, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        rateApp()
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1481716712") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    func setupNavBar() {
        self.navigationItem.title = " Questions"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       
    }
    
}

extension FAAViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if expandedCellIndex == indexPath.row {
            return UITableView.automaticDimension
        }
        return 20 + 62 + 20
    }
    
}

extension FAAViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "ExpandableTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ExpandableTableViewCell
        cell.setButtonHidden(true)
        cell.delegate = self
        if ( indexPath.row == 0 ){
        cell.titleLabel.text = "How to book an arena ?"
            cell.cellTextLabel.text = "Find the nearest arena, Select an hour you wanna play and press the book button "}
        if ( indexPath.row == 1 ){
          cell.titleLabel.text = "How to check the status of my booking ?"
              cell.cellTextLabel.text = "Once you booked your hour it will appear in the bookings section in your homepage , The inital state will be waiting for approval"}
        if ( indexPath.row == 2 ){
          cell.titleLabel.text = "What does waiting for approval mean ?"
              cell.cellTextLabel.text = " It means that our admin is booking the arena for you , Once it's booked the status will change from waiting for approval to accepted "}
        if ( indexPath.row == 3 ){
          cell.titleLabel.text = "My booking is accepted , What's next ?"
              cell.cellTextLabel.text = " When your booking is accepted it means that we have booked you your arena , Our admin will call you to confirm with you "}
        if ( indexPath.row == 4 ){
        cell.titleLabel.text = "Why my booking is declined ?"
            cell.cellTextLabel.text = "When your booking is declined it means that the provider didn't accept your booking , Wait for our admin to call you to book you another near by arena"}
        return cell
    }
    
}

extension FAAViewController: ExpandableTableViewCellDelegate {
    
    func cellButtonDidTap(cell: ExpandableTableViewCell) {
        
    }
    
    func toggleExpansion(cell: ExpandableTableViewCell) {
        let indexPath = tableView.indexPath(for: cell)!
        expandedCellIndex = expandedCellIndex == indexPath.row ? nil : indexPath.row
        tableView.beginUpdates()
        tableView.endUpdates()
        if expandedCellIndex != nil {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
}
