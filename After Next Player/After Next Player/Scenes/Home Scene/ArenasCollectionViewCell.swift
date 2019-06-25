//
//  ArenasCollectionViewCell.swift
//  After Next Player
//
//  Created by mahmoud mohamed on 6/23/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import Cosmos

protocol ArenaBookedProtocol {
    func arenaBooked(index:Int)
}
class ArenasCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingStarsView: CosmosView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var index:IndexPath?
    var delegate:ArenaBookedProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    func config(){
      //  ratingStarsView.rating = 0
        cellView.layer.cornerRadius=5
        cellView.layer.shadowRadius = 0.3
        cellView.layer.shadowColor=UIColor(red: 229/255, green: 236/255, blue: 237/255, alpha: 1).cgColor
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowOffset = CGSize(width: 1, height: 3)
        //cellView.layer.borderColor=UIColor.gray.cgColor
        cellView.layer.borderWidth=0.05
    }

    
    
    @IBAction func bookPressed(_ sender: Any) {
        delegate?.arenaBooked(index: index!.row )
    }
    
    
}
