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
    var number : String
    init(name:String,location:String,price:String,hours:[Bool],number:String) {
        self.hours = hours
        self.name = name
        self.location = location
        self.price = price
        self.rating = 0
        self.number=number
        
    }
}
extension Arena :Equatable{
    static func == (lhs: Arena, rhs: Arena) -> Bool {
        return (lhs.name == rhs.name && lhs.price==rhs.price)
    }
    
    
}
