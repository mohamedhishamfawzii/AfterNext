//
//  BookingsTableViewCell.swift
//  After Next Player
//
//  Created by mohamed hisham on 6/23/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
protocol bookingProtocol {
    func acceptClicked(index:Int)
     func declineClicked(index:Int)
}

class BookingsTableViewCell: UITableViewCell {
    @IBOutlet weak var timeSquare: UIView!

    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var arenaLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    var delegate:bookingProtocol?
    var index:Int!
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
    }
    
    @IBAction func declineClicked(_ sender: Any) {
        delegate?.declineClicked(index: index)
    }
    @IBAction func approveClicked(_ sender: Any) {
        delegate?.acceptClicked(index: index)
    }
    
}
