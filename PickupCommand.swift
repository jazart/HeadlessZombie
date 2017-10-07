//
//  PickupCommand.swift
//  StarterGame
//
//  Created by Jerum on 5/2/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class PickupCommand : Command{
    override init(){
        super.init()
        self.name = "pickup"
    }
    
    override func execute(_ player: Player) -> Bool {
        let roomItems = player.currentRoom.inventory
        
        if(hasThirdWord() && hasSecondWord()){
            let itemToPickup = secondWord! + " " + thirdWord!
            if(roomItems.items.count > 0){
                player.pickup(itemToPickup, roomItems)
                return false
            }
        }
        if(hasSecondWord()){
            if(roomItems.items.count > 0) {
                player.pickup(secondWord!, roomItems)
                return false
            }
        
        player.errorMessage("\nThere's nothing in this room.")
        return false
        }
        
        player.errorMessage("\nPickup what?")
        return false
    }
    
    override func description() -> String? {
        return "With this command you can pick up items from the room"
    }
}
