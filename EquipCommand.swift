//
//  EquipCommand.swift
//  StarterGame
//
//  Created by Jerum on 5/7/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class EquipCommand : Command {
    override init(){
        super.init()
        self.name = "equipweapon"
    }
    
    override func execute(_ player: Player) -> Bool {
        if(hasThirdWord() && hasSecondWord()){
            player.equipW(secondWord! + " " + thirdWord!)
            return false
        }
        if(hasSecondWord()){
            player.equipW(secondWord!)
            return false
        }
        
        return false
    }
}
