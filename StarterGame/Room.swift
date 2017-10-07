//
//  Room.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/16/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation

class Room : RoomProtocol{
    func setContainer(_ containerRoom: Room) {
        
    }

   // var exits : [String : Room]
    var doors : [String : Door]
    var tag : String
    var npc : NPC?
    var market : Bool
    var inventory : Inventory
    private var _delegate : RoomProtocol?
    var delegate : RoomProtocol{
        get {return _delegate!}
        set{_delegate = newValue}
    }
    
    convenience init() {
        self.init(tag: "No Tag")
    }
    
    init(tag : String) {
        //exits = [String : Room]()
        doors = [String : Door]()
        self.tag = tag
        self.inventory = Inventory()
        self.market = false
    }
    
    func setExit(_ exitName : String, door : Door) {
        doors[exitName] = door
    }
    
    func getExit(_ exitName : String) -> Door? {
        return doors[exitName]
    }
    
    func getExits() -> String {
        let exitNames : [String] = [String](doors.keys)
        return "Exits: " + exitNames.joined(separator: " ")
    }
    
    func addNPC(_ npc : NPC){
        self.npc = npc
    }
    
    
    func description() -> String {
        return "You are \(tag).\n *** \(self.getExits())"
    }
    
    
    
    deinit {
        tag = ""
        doors.removeAll()
    }
}
