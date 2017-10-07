//
//  Command.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation

class Command {
    var name : String
    var secondWord : String?
    var thirdWord : String?
    
    init() {
        self.name = ""
    }
    
    func hasSecondWord() -> Bool {
        return secondWord != nil
    }
    
    func hasThirdWord() -> Bool{
        return thirdWord != nil
    }
    
    func execute(_ player : Player) -> Bool {
        return false
    }
    
    func description() -> String?{
        return ""
    }
}
