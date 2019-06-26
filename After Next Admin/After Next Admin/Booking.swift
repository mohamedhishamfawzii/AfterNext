//
//  Booking.swift
//  After Next Player
//
//  Created by mohamed hisham on 6/25/19.
//  Copyright © 2019 hisham. All rights reserved.
//

import Foundation
class Booking{
    
    var arenaName:String
    var playerName:String
    var arenaLocation:String
    var playerMobile:String
    var approved:Bool
    var status:String
    var played:Bool
    var notes:String
    init(arena:String,location:String) {
        self.arenaLocation=location
        self.arenaName=arena
        self.approved=false
        self.playerName="Mohamed Hisham"
        self.playerMobile="01001302801"
        self.played=false
        self.notes=""
        self.status="Waiting Approval"
    }
    
}
