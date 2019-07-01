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
    var arenaNumber:String
    
    init(arena:String,location:String,hour:String,arenaNumber:String) {
        self.arenaLocation=location
        self.arenaName=arena
        self.hour=hour
        self.approved=false
        self.playerName=UserDefaults.standard.string(forKey: "name")!
        self.playerMobile=UserDefaults.standard.string(forKey: "mobile")!
        self.played=false
        self.notes=""
        self.status="Waiting Approval"
        self.arenaNumber=arenaNumber
    }
    init(arena:String,location:String,hour:String,arenaNumber:String,playerName:String,playerNumber:String) {
        self.arenaLocation=location
        self.arenaName=arena
        self.hour=hour
        self.approved=false
        self.playerName=playerName
        self.playerMobile=playerNumber
        self.played=false
        self.notes=""
        self.status="Waiting Approval"
        self.arenaNumber=arenaNumber
    }
    
}
extension Booking :Equatable{
    static func == (lhs: Booking, rhs: Booking) -> Bool {
        return (lhs.arenaName == rhs.arenaName && lhs.hour==rhs.hour)
    }
    
    
}
