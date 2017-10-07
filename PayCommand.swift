//
//  PayCommand.swift
//  StarterGame
//
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation


class PayCommand: Command{
    override init(){
        super.init()
        self.name = "pay"
    }
    override func execute(_ player: Player) -> Bool {
        if hasSecondWord(){
            player.warningMessage("\nI cannot pay/ \(String(describing: secondWord))")
        }
        else{
            player.pay()
        }
        return false
    }
    
}
