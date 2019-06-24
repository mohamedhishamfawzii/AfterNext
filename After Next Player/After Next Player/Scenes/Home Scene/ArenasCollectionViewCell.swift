//
//  ArenasCollectionViewCell.swift
//  After Next Player
//
//  Created by mahmoud mohamed on 6/23/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class ArenasCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var star1Button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        config()
    }
    
    @IBAction func starTapped(_ sender: Any) {
        
    }
    func config(){
        cellView.layer.cornerRadius=5
        cellView.layer.shadowRadius = 0.3
        cellView.layer.shadowColor=UIColor(red: 229/255, green: 236/255, blue: 237/255, alpha: 1).cgColor
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowOffset = CGSize(width: 1, height: 3)
        //cellView.layer.borderColor=UIColor.gray.cgColor
        cellView.layer.borderWidth=0.05
    }

}
