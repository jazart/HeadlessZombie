//
//  ViewInventoryCommand.swift
//  StarterGame
//
//  Created by Jerum on 4/16/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class ViewInventoryCommand : Command{
    
    override init() {
        super.init()
        self.name = "view"
    }
    
    override func execute(_ player: Player) -> Bool {
        if(hasSecondWord()){
            if(secondWord!.lowercased() == "inventory"){
                player.displayLongInventory()
                return false
            }
            if(secondWord?.lowercased() == "room"){
                if(player.currentRoom.inventory.items.count < 1){
                    player.errorMessage("\nThere's nothing in this room")
                    return false
                }
                for item in player.currentRoom.inventory.items{
                    player.outputMessage("\nName: " + item.key + " | Value:\(item.value.value) |  Weight: \(item.value.weight)")
                }
                return false
            }
            if(secondWord! == "wear"){
                player.displayWear()
                return false
            }
            else{
                player.outputMessage("view what?")
                return false
            }
        }
        player.displayStatus()
        return false
    }
    
    override func description() -> String? {
        return "With this command you can say 'view' to view your health and player info, 'view room' to view items in the room, and 'view inventory to view what's in your inventory"
    }
}
