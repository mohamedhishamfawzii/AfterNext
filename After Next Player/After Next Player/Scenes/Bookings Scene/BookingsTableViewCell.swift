//
//  BookingsTableViewCell.swift
//  After Next Player
//
//  Created by mohamed hisham on 6/23/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit

class BookingsTableViewCell: UITableViewCell {
    @IBOutlet weak var timeSquare: UIView!
    
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius=5
        cellView.layer.shadowRadius = 0.3
       timeSquare.layer.cornerRadius=2
        cellView.layer.shadowColor=UIColor(red: 229/255, green: 236/255, blue: 237/255, alpha: 1).cgColor
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cellView.layer.borderColor=UIColor.gray.cgColor
        cellView.layer.borderWidth=0.05
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
