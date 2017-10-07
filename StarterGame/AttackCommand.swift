//
//  AttackCommand.swift
//  StarterGame
//
//  Created by Jerum on 4/27/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class AttackCommand : Command{
    override init(){
        super.init()
        self.name = "attack"
    }
    
    override func execute(_ player: Player) -> Bool {
        if player.battle == false || player.currentRoom.npc == nil{
            player.errorMessage("\nYou can only attack if you're in battle")
            return false
        }
        player.battle(player.currentRoom.npc!, self.name)
        return false
    }
    
    override func description() -> String? {
        return "With this command you can attack enemies"
    }
}
