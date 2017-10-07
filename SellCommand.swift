//
//  SellCommand.swift
//  StarterGame
//
//  Created by Jerum on 5/7/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class SellCommand : Command {
    override init(){
        super.init()
        self.name = "sell"
    }
    
    override func execute(_ player: Player) -> Bool {
        if(player.currentRoom.market){
            if(hasSecondWord() && hasThirdWord()){
                player.sell(secondWord! + " " + thirdWord!)
                return false
            }
            if(hasSecondWord()){
                player.sell(secondWord!)
                return false
            }
            
        }
        player.errorMessage("\nYou can only sell items in the marketplace.")
        return false 
    }
}
