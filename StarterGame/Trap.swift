//
//  Trap.swift
//  StarterGame
//
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
//Trap Room

class Trap : Room {
    private var isTrapped : Bool = true
    
    override init(tag : String) {
        super.init(tag : tag)
        let nc = NotificationCenter.default
        nc.addObserver(forName:Notification.Name(rawValue:"PlayerDidPayFee"), object: nil,queue : nil, using: playerPaidFee)
    }
    
    override func getExit(_ exitName : String) -> Door? {
        if isTrapped == true {
        return self as! Door
        }
        else{
            return super.getExit(exitName) as! Door
        }
    }
    func playerPaidFee(notification : Notification) -> Void{
        isTrapped = false
    }
    
    override func description() -> String {
        if !isTrapped{
            return super.description()
        }
        else{
            return "\(super.description())\n You must pay to get out of here"
        
    }
    
}
}
