//
//  QuitCommand.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation

class QuitCommand: Command {
    
    override init() {
        super.init()
        self.name = "quit"
    }
    
    override func execute(_ player: Player) -> Bool {
        var answer : Bool = true
        if hasSecondWord() {
            player.warningMessage("\nI cannot quit \(secondWord)")
            answer = false
        }
        return answer
    }
    
    override func description() -> String? {
        return "This command ends the game"
    }
}
