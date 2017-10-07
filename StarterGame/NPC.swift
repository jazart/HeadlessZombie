//
//  NPC.swift
//  StarterGame
//
//  Created by Jerum on 4/26/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class NPC {
    private var _currentRoom : Room?
    var currentRoom : Room?{
        get{
            return _currentRoom
        }
        set{
            _currentRoom = newValue
        }
    }
    
    //var io : GameOutput
    private var _inventory : Inventory
    var inventory : Inventory{
        get{
            return _inventory
        }
        set{
            _inventory = newValue
        }
    }
    private var _atk : Double
    var atk : Double{
        get{
            return _atk + (self.weapon?.attack)! + (self.armor?.attack)! + (self.helmet?.attack)!
        }
        set{
            _atk = newValue
        }
    }
    private var _def : Double
    var def : Double{
        get{
            return _def + (self.weapon?.attack)! + (self.armor?.attack)! + (self.helmet?.attack)!
        }
    }

    
    var currentGold : Int
    var health : Double
    var helmet : Equipment?
    var armor : Equipment?
    var weapon : Equipment?
    var option : String
    var level : Int = 1
    private var weapons = ["dagger", "longsword", "spear"]
    private var names = ["goblin", "bandit", "Ogre"]
    private var _name : String = "none"

    var name : String{
        get{
            return _name
        }
        set{
            _name = newValue
        }
    }
    //initailizer creates a random leveled monster for the player to battle
    init(_ room : Room, _ npcName: String, _ playerLevel : Int) {
        _currentRoom = room
        _atk = 0
        _def = 0
       // io = output
        _inventory = Inventory()
        let leveledAtk = Double(playerLevel) * Double(arc4random_uniform(5))
        let leveledDef = Double(playerLevel) * Double(arc4random_uniform(5))
        weapon = Equipment(leveledAtk, leveledDef, weapons[Int(arc4random_uniform(3))])
        armor = Equipment(leveledAtk, leveledDef, "armor")
        helmet = armor
        currentGold = 5 * level
        health = Double(15 * level)
        level = Int(arc4random_uniform(UInt32(playerLevel))) + 1
        option = "none"
        _name = npcName
    }
    
    convenience init(_ room: Room) {
        self.init(room, "none", 3)
        self.name = names[Int(arc4random_uniform(3))]
    }
   
    
    
    
    
}
