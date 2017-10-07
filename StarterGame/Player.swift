//
//  Player.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/16/16.
//  Copyright © 2016 Rodrigo Obando. All rights reserved.
//

import Foundation
import Cocoa

class Player {
    var currentRoom : Room
    var io : GameOutput
    var inventory : Inventory
    var currentGold : Int
    var moves : [Room]
    var health : Double
    var helmet : Equipment?
    var armor : Equipment?
    var weapon : Equipment?
    var battle = false
    var xp = 0
    var level : Int
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
    init(room : Room, output : GameOutput) {
        currentRoom = room
        io = output
        inventory = Inventory()
        weapon = Equipment(3, 3, "Wooden sword")
        helmet = Equipment(5,5, "Wooden Helmet")
        armor = Equipment(10, 10, "Wooden Armor")
        _def = 0
        _atk = 0
        let potion = Equipment(3,3,"beer")
        inventory.addItem(item: potion)
        moves = [Room]()
        currentGold = 10
        health = 15
        self.level = 1
    }
    
    func equipH(_ item : String){
        inventory.addItem(item: helmet!)
        let temp = inventory.items[item] as? Equipment
        if( temp != nil){
            helmet = temp
            self.outputMessage("\nItem equipped")
            return
        }
        self.errorMessage("\nItem not found.")
    }
    
    func equipW(_ item : String){
        inventory.addItem(item: weapon!)
        let temp = inventory.items[item] as? Equipment
        if( temp != nil){
            weapon = temp
            self.outputMessage("\nItem equipped")
            return
        }
        self.errorMessage("\nItem not found.")
    }
    
    func equipA(_ item : String){
        inventory.addItem(item: armor!)
        let temp = inventory.items[item] as? Equipment
        if( temp != nil){
            armor = temp
            self.outputMessage("\nItem equipped")
            return
        }
        self.errorMessage("\nItem not found.")
        
    }
    
    func drink(_ item : String){
        var drink : Consumable?
        drink = self.inventory.items[item] as? Consumable
        if(drink != nil){
            self.health += ((drink?.healthBoost)! - (drink?.healthDreain)!)
        }
    }
    
    func walkTo(_ direction : String) {
        let nc = NotificationCenter.default
        let door : Door? = currentRoom.getExit(direction)
        if door != nil {
            if door!.isOpen() {
                let nextRoom: Room? = door?.room(otherRoom: currentRoom)
                if nextRoom != nil {
                    nc.post(Notification.init(name: Notification.Name(rawValue: "PlayerWillEnterRoom"), object: nextRoom!))
                    nc.post(Notification.init(name: Notification.Name(rawValue: "enemyEncounter"), object :
                        nextRoom!))
                    nc.post(Notification.init(name: Notification.Name(rawValue:"exploredWorld"), object: self.currentRoom))
                    nc.post(Notification.init(name: Notification.Name(rawValue:"enemyEncountered"), object: self.currentRoom))
                    self.currentRoom = nextRoom!//Event occured, but we already informed that this event will happen and will notify when it does
                    moves.append(self.currentRoom)
                    nc.post(Notification.init(name: Notification.Name(rawValue:"exploredWorld"), object: self))
                    nc.post(Notification.init(name: Notification.Name(rawValue: "PlayerDidEnterRoom"), object: self.currentRoom))
                    nc.post(Notification.init(name: Notification.Name(rawValue: "enemyEncountered"), object : self))
                    self.battle = true
                    self.outputMessage("\n\(nextRoom!.description())")
                }
            }
            else {
                self.errorMessage("\nThere is no door on '\(direction)' is closed")
            }
        }
        else{
            self.errorMessage("\nThere is no room here.")
        }
    }
    
    func turnBack(){
        let prev = moves.popLast()
        if prev != nil{
            currentRoom = prev!
            self.outputMessage("You have gone back to: " + currentRoom.description())
        }
        else{
            self.errorMessage("You have gone back to your first move")
        }
    }

    
    
    func pay(){
        let nc = NotificationCenter.default
        nc.post(Notification.init(name: Notification.Name(rawValue: "PlayerDidPayFee"), object: nil))
        self.outputMessage("\n I payed the fee. ", color: NSColor.blue)
    }
    
    func unlock(_ direction : String){
        let door : Door? = currentRoom.getExit(direction)
            if door != nil{
                door!.unlock()
                if door!.isUnlocked(){
                    self.commandMessage("\nThe door on \(direction) is unlocked")
                }
                else{
                    self.commandMessage("\nThe door on \(direction) is locked.")
                }
            }
            else {
                self.commandMessage("There is on door on \(direction).")
            }
    }
    
    func drop(_ item : String){

        if(inventory.items[item] != nil){
            //self.inventory.removeItem(item: item)
            var currentItem : Item?
            currentItem = inventory.removeItem(item: item)
            self.currentRoom.inventory.addItem(item: currentItem!)
            self.outputMessage("\(item) Has been dropped from inventory")
            return
        }
        else{
            self.errorMessage("The item: '\(item)' is not in your inventory")
        }
    }
    
    func sell(_ item : String){
        if(inventory.items[item] != nil){
            let currentItem : Item? = inventory.removeItem(item: item)
            self.currentRoom.inventory.addItem(item: currentItem!)
            self.currentGold += (currentItem?.value)!
            self.outputMessage("\n You sold \((currentItem?.name)!) for \((currentItem?.value)!) gold.")
            return
        }
        self.errorMessage("\nThis item '\(item)' isn't in your inventory.")
    }
    
    func displayStatus(){
        self.outputMessage("\nHealth : \(self.health) \nCarry Capacity: \(self.inventory.currentCapacity) \nXP: \(self.xp) \nGold: \(self.currentGold)")
    }
    
    func displayWear(){
        self.outputMessage("\nHere are your weapons current condion: \n\((self.weapon?.name)!)\((self.weapon?.condition)! * 100.0) \n\((self.armor?.name)!) \((self.armor?.condition)! * 100.0) \n\((self.helmet?.name)!) \((self.helmet?.condition)! * 100.0)")
    }
    func displayLongInventory(){
        self.outputMessage("Here is a detailed descripton of the items in your invetory:\n")
        for item in inventory.items{
            self.outputMessage("\n Name: " + item.key + " | Value: " + "\(item.value.value) " + "| Weight: " + "\(item.value.weight) ")
        }
    }
    //the most complex and convoluted method in the game, originally a switch based method in a while loop to allow for turn based combat. However the command wont allow for multiple inputs so it just goes with one battle command
    //the method esentially compares the npc's and player's atk/def and takes the damage to the weaker one
    //the npc randomlly chooses to attack or defend, no ai.
    func battle(_ npc : NPC, _ option : String){
        var cpuOption = ["attack", "defend", "attack", "defend", "defend"]
       // var flee = false
        var damage : Double
        while(self.health > 1 || npc.health > 1){
            npc.option = cpuOption[Int(arc4random_uniform(4))]
            switch option {
            case "attack":
                if npc.option == "attack"{
                    if (self.atk > npc.atk){
                        damage = self.atk - npc.atk
                        self.outputMessage("\nThe \(npc.name) chose to attack with \((npc.atk)) attack damage! Your attack is stronger and did \(damage) damage", color: NSColor.green)
                        npc.health -= damage
                        self.weapon?.condition -= 0.05
                        npc.weapon?.condition -= 0.1
                        break;

                    }
                    else if( npc.atk > self.atk){
                        
                        damage = npc.atk - self.atk
                        self.outputMessage("\nThe \(npc.name) chose to attack with \((npc.atk)) attack damage! Your attack is weaker and \(damage) damage was inflicted upon you!", color: NSColor.red)
                        
                        self.health -= damage
                        self.weapon?.condition -= 0.1
                        npc.weapon?.condition -= 0.05
                        break;
                    }
                    else{
                        self.outputMessage("\nThis clash was a draw! This makes you both stronger and tap deeper into your power!", color: NSColor.orange)
                        npc.atk += Double(npc.level)
                        self.atk += Double(self.level)
                        continue;
                    }
                }
                if npc.option == "defend"{
                    self.outputMessage("\n\(npc.name) chose to defend")
                    if (npc.armor?.defense)! >= (self.weapon?.attack)!{
                        self.outputMessage("\nYour attack was ineffective!", color: NSColor.red)
                        self.weapon?.condition -= 0.1
                        npc.armor?.condition -= 0.05
                        break;
                    }
                    else{
                        damage = self.atk - npc.def
                        self.outputMessage("\nYour attack broke through \(npc.name)'s defenses and did \(damage) damage!", color: NSColor.green)
                        npc.health -= damage
                        npc.armor?.condition -= 0.1
                        self.weapon?.condition -= 0.05
                        break;
                    }
                }
                break;
            case "defend":
                if npc.option == "attack"{
                    if (self.armor?.defense)! < (npc.weapon?.attack)!{
                        self.health = self.health - ((npc.weapon?.attack)! + (self.armor?.defense)!)
                    }
                }
                if npc.option == "defense"{
                    break
                }
                break;
                
            default:
                break;
            }
            //rewards the player with gold, xp and makes the room's npc nil. Also notifies observers to possiblilty that the player leveled up or killed the witch.
            if npc.health < 1 {
                let goldEarned = npc.currentGold
                let xpEarned = self.level * (npc.level + Int(arc4random_uniform(UInt32(self.level)))) + 10
                self.currentGold += npc.currentGold
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue:"witchDied"), object: self)
                nc.post(name: Notification.Name(rawValue:"gainedXp"), object: self)
                xp += xpEarned
                nc.post(name: Notification.Name(rawValue:"gainedXp"), object: self)
                self.currentRoom.npc = nil
                self.outputMessage("\nCongrats, you win!. You earned \(goldEarned) Gold and \(xpEarned)! xp. ")
                break;
            }
            //notifies observer to end game if the player dies in battle
            if self.health < 1 {
                self.outputMessage("\nYOU LOSE!!", color: NSColor.red)
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue:"playerDied"), object: self)
                break;
            }
            self.outputMessage("\nYour turn: Attack or Defend\n")

            
        }
    }
    
    func levelUp(){
        self.level += 1
        self.xp = 0
        self.health += 20
        self._atk += 5
        self._def += 5
        self.currentGold += 50
        self.inventory.currentCapacity += 20
        self.outputMessage("\nWow you just leveled up to level \(self.level)!!. \nHealth: \(self.health)\nAtk: \(self._atk) \nDef: \(self._def) \nGold: \(self.currentGold) \nCarry Capacity: \(inventory.currentCapacity)", color: NSColor.green)
    }
    //check to see if room is market and picks the item up if it's just a regular room. Also makes sure the item isn't unobatianable
    func pickup(_ item: String, _ room : Inventory ){
        if currentRoom.market {
            self.errorMessage("\nYou must buy this item!")
            return 
        }
        if(room.items[item] != nil){
            let pickupItem = room.removeItem(item: item)
            if(!(pickupItem?.obtainable)!){
                room.addItem(item: pickupItem!)
                self.errorMessage("\nSorry you cannot pick up this item")
                return
            }
            self.inventory.addItem(item : pickupItem!)
            if(self.inventory.overCapacity()){
                self.errorMessage("\nThis item puts you over your carry capacity. Unable to add")
                self.inventory.removeItem(item: item)
                return
            }
            self.outputMessage("\nItem added")
            return
        }
        
        self.errorMessage("\nItem not found")
    }
    //same as pickup method but makes sure the player is at the market and awards the player gold for the value of their item
    func buy(_ item: String, _ room : Inventory){
        if(room.items[item] != nil){
        let itemToPurchase : Item? = room.removeItem(item: item)
            if((itemToPurchase?.value)! <= self.currentGold){
                self.currentGold -= (itemToPurchase?.value)!
                self.inventory.addItem(item: itemToPurchase!)
                if(self.inventory.overCapacity()){
                    self.errorMessage("\nThis item puts you over your carry capacity. Unable to add")
                    self.inventory.removeItem(item: item)
                    return
                }
                self.outputMessage("\nItem added")
                return
            }
            else{
                self.errorMessage("\nYou do not have enough gold to purchase this item.")
                return
            }
        }
        self.errorMessage("\nItem not found")
    }
    
    func outputMessage(_ message : String) {
        io.sendLine(message)
    }
    
    func outputMessage(_ message : String, color : NSColor) {
        let lastColor : NSColor = io.currentColor
        io.currentColor = color
        self.outputMessage(message)
        io.currentColor = lastColor
    }
    
    func errorMessage(_ message : String) {
        self.outputMessage(message, color: NSColor.red)
    }
    
    func warningMessage(_ message : String) {
        self.outputMessage(message, color: NSColor.orange)
    }
    
    func commandMessage(_ message : String) {
        self.outputMessage(message, color: NSColor.brown)
    }
}
