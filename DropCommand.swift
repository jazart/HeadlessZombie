//
//  DropCommand.swift
//  StarterGame
//
//  Created by Jerum on 4/13/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class DropCommmand : Command{
    override init(){
        super.init()
        self.name = "drop"
    }
    
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord() && hasThirdWord(){
            let name = secondWord! + " " + thirdWord!
            player.drop(name)
        }
        else if hasSecondWord(){
            player.drop(secondWord!)
        }
        else{
            player.warningMessage("Drop What?")
        }
        return false
    }
    
    override func description() -> String? {
        return "With this command you can drop items from your inventory and clear up capacity space"
    }
}
