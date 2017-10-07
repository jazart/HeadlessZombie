//
//  Parser.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/17/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation

class Parser {
    var commands : CommandWords
    
    init(newCommands : CommandWords) {
        commands = newCommands
    }
    
    func parseCommand(_ commandString : String) -> Command? {
        
        var command : Command? = commands.get("")
        let words = commandString.components(separatedBy: " ")
        if words.count > 0 {
            command = commands.get(words[0])
            if command != nil {
                if words.count > 1 {
                    if words.count > 2{
                        command?.thirdWord = words[2]
                    }
                    command?.secondWord = words[1]
                }
                else {
                    command?.secondWord = nil
                    command?.thirdWord = nil
                }
            }
        }
        
        return command
    }
    
    func description() -> String {
        return commands.description()
    }
}
