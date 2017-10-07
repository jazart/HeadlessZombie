//
//  BackCommand.swift
//  StarterGame
//
//  Created by Jerum on 4/16/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class BackCommand : Command{
    override init(){
        super.init()
        self.name = "back"
    }
    
    override func execute(_ player: Player) -> Bool {
        player.turnBack()
        return false
    }
    
    override func description() -> String? {
        return "With this command you can go back to the previous room you were in."
    }
}
