//
//  NoBookingsTableViewCell.swift
//  After Next Player
//
//  Created by mohamed hisham on 11/9/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import SwiftGifOrigin
class NoBookingsTableViewCell: UITableViewCell {
    @IBOutlet weak var elKalam: UILabel!
    
    @IBOutlet weak var gif: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       gif.loadGif(name: "error")
        gif.startAnimating()
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
