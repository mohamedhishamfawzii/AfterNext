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
    var hour:String
    var id:String
    var arenaNumber:String
    init(arena:String,location:String,hour:String,arenaNumber:String,playerName:String,playerNumber:String,id:String) {
        self.hour=hour
        self.arenaLocation=location
        self.arenaName=arena
        self.approved=false
        self.playerName=playerName
        self.playerMobile=playerNumber
        self.played=false
        self.notes=""
        self.status="Waiting Approval"
        self.arenaNumber=arenaNumber
        self.id=id
    }
    
}
