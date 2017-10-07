//
//  OpenCommand.swift
//  StarterGame
//
//  Created by Jerum on 4/11/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class OpenCommand : Command {
    
    override init(){
        super.init()
        super.name = "open"
    }
    
    override func execute(_ player: Player) -> Bool {
        return false
    }
}
