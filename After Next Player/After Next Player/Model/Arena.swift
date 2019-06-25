//
//  Arena.swift
//  After Next Player
//
//  Created by mohamed hisham on 6/25/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import Foundation
class Arena {
    var name : String
    var location: String
    var rating : Int
    var price: String
    var hours : [Bool]
    init(name:String,location:String,price:String) {
        self.hours = [Bool](repeatElement(false,count: 8))
        self.name = name
        self.location = location
        self.price = price
        self.rating = 0
        
    }
}
