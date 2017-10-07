//
//  BuyCommand.swift
//  StarterGame
//
//  Created by Jerum on 5/2/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class BuyCommand : PickupCommand{
    override init(){
        super.init()
        self.name = "buy"
    }
    
    override func execute(_ player: Player) -> Bool {
        let roomItems = player.currentRoom.inventory
        if(hasThirdWord() && hasSecondWord()){
            if(roomItems.items.count > 0){
                let itemToBuy = secondWord! + " " + thirdWord!
                player.buy(itemToBuy, roomItems)
            }
        }
        if(hasSecondWord()){
            
            if(roomItems.items.count > 0) {
                player.buy(secondWord!, roomItems)
                return false
            }
            
            player.errorMessage("\nThere's nothing in this room.")
            return false
        }
        
        player.errorMessage("\nBuy what?")
        return false
    }
    
    override func description() -> String? {
        return "With this command you can buy items at the market"
    }
}
