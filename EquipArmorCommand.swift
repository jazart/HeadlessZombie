//
//  EquipArmorCommand.swift
//  StarterGame
//
//  Created by Jerum on 5/7/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class EquipArmorCommand : Command {
    override init(){
        super.init()
        self.name = "equiparmor"
    }
    
    override func execute(_ player: Player) -> Bool {
        if(hasThirdWord() && hasSecondWord()){
            player.equipA(secondWord! + " " + thirdWord!)
            return false
        }
        if(hasSecondWord()){
            player.equipA(secondWord!)
            return false
        }
        
        return false
    }
}
