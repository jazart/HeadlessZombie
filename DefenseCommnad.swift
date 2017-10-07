//
//  DefenseCommnad.swift
//  StarterGame
//
//  Created by Jerum on 4/29/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
//defunct..not being used
class DefenseCommand : Command{
    override init(){
        super.init()
        self.name = "defend"
    }
    
    override func execute(_ player: Player) -> Bool {
        if player.battle == false{
            player.errorMessage("\nYou can only attack if you're in battle.")
        }
        player.battle(player.currentRoom.npc!, self.name)
        return false
    }
    
    override func description() -> String? {
        return "dead command"
    }
    

}
