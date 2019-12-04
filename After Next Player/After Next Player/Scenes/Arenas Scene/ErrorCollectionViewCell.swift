//
//  ErrorCollectionViewCell.swift
//  After Next Player
//
//  Created by mohamed hisham on 11/9/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import UIKit
import SwiftGifOrigin
class ErrorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var gif: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        gif.loadGif(name: "error")
               gif.startAnimating()
        // Initialization code
    }

}
