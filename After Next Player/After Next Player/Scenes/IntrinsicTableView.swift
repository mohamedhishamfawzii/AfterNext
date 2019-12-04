//
//  IntrinsicTableView.swift
//  BlueBus
//
//  Created by mahmoud mohamed on 7/22/19.
//  Copyright © 2019 BlueBus. All rights reserved.
//

import UIKit

class IntrinsicTableView: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return contentSize
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
    
}
