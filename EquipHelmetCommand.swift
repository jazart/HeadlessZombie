//
//  EquipHelmetCommand.swift
//  StarterGame
//
//  Created by Jerum on 5/7/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class EquipHelmetCommand : Command {
    override init(){
        super.init()
        self.name = "equiphelmet"
    }
    
    override func execute(_ player: Player) -> Bool {
        if(hasThirdWord() && hasSecondWord()){
            player.equipH(secondWord! + " " + thirdWord!)
            return false
        }
        if(hasSecondWord()){
            player.equipH(secondWord!)
            return false
        }
        
        return false
    }
}
