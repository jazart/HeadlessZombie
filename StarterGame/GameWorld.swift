//
//  GameWorld.swift
//  StarterGame
//
// 
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation


class GameWorld{
    static let sharedInstance : GameWorld = GameWorld() //singleton
    private var _entrance : Room? //makes the entrance optional since before initialization, it is empty or nil; the _ makes it a property
    private var _trigger : Room?
    let marketplace = Room(tag: "At the marketplace. You can buy and sell goods here.")
    var entrance : Room{
        get {
            return _entrance!
        }
    }
    var trigger : Room{
        get {
            return _trigger!
        }
    }
    
    private init(){
        _entrance = createWorld()
        //saves the entrance of the newly created world; _ is internally; no _ is externally
    }
    
    //randomlly generates items for the player that are leveled and randomly can or cannot be picked up
    func generateItems(player : Player){
        let names = ["rusty sword", "Ancient Blade", "Katana", "Helm", "Steel Armor"]
        for i in (0..<player.moves.count){
            let currentRoom = player.moves[i]
            let randAtk = Double(arc4random_uniform(UInt32(player.level)))
            let randDef = Double(arc4random_uniform(UInt32(player.level)))
            let name = names[Int(arc4random_uniform(5))]
            let item = Equipment(randAtk, randDef, name)
            item.obtainable = arc4random_uniform(5) > arc4random_uniform(6) ? true : false
            currentRoom.inventory.addItem(item: item)
        }
    }
    //makes a room a marketplace and can serve to update a marketplace with better items as the player levels up.
    func makeMarket(room : Room, playerLevel : Double){
        room.market = true
        var weapons = ["Dagger", "Sword", "Longsword", "Axe", "Warhammer"]
        var armor = ["Shield", "Helmet", "Robe", "Ring"]
        var consumables = ["Potion", "Poison", "Mysterydrink"]
        
        for i in (0..<5){
            let attack = Double(arc4random_uniform(5)) * playerLevel
            let defense = Double(arc4random_uniform(5)) * playerLevel
            var product = Equipment(attack, defense, weapons[i])
            if(playerLevel >= 3 && playerLevel < 5){
                product = IronEquipmentDecoratorA(product)
            }
            if(playerLevel >= 5){
                product = OrichalumEquipmentDecarator(product)
            }
            room.inventory.addItem(item: product)
        }
        
        for j in (0..<4){
            let attack = Double(arc4random_uniform(5)) * playerLevel
            let defense = Double(arc4random_uniform(5)) * playerLevel
            var armorProduct = Equipment(attack, defense, armor[j])
            if(playerLevel > 3 && playerLevel < 5){
                armorProduct = IronEquipmentDecoratorA(armorProduct)
            }
            if(playerLevel >= 5){
                armorProduct = OrichalumEquipmentDecarator(armorProduct)
            }
            room.inventory.addItem(item: armorProduct)
        }
        //switch statement to generate items appropriately
        for k in (0..<3){
            for _ in(0..<5){
                let name = consumables[k]
                let value = Int(arc4random_uniform(5)) * Int(playerLevel)
                var drink : Consumable?
                switch name{
                    case "Potion":
                        drink = Consumable(Double(value), 0, name)
                        break;
    
                    case "Poison":
                        drink = Consumable(0, Double(value), name)
                        break;
                    case "Mysterydrink":
                        drink = value % 2 == 0 ? Consumable(Double(value), 0, name) : Consumable(0, Double(value), name)
                        break;
                    default:
                        break;
                }
                room.inventory.addItem(item: drink!)
            }
        }
    }
    //populates the world once the player moves around the world. Will continously populate leveled eneimies every x moves
    func populateWorld(player : Player){
        for i in (0..<player.moves.count){
            let currentRoom = player.moves[i]
            if(currentRoom.npc == nil){
                currentRoom.addNPC(NPC(currentRoom))
            }
        }
        //return entrance
    }
    //creates and connects room. Witch and her dragon are explicitly created since they are boss characters
    private func createWorld() -> Room {
        let swiftville = Room(tag: "In Swiftville outside the main entrance of the Witche's lair")
        let graveyard = Room(tag: "in the graveyard")
        let blackForestE = Room(tag: "in the eastern area of the Black Forest")
        
        blackForestE.addNPC(NPC(blackForestE))
        
      //  let marketplace = Room(tag: "At the marketplace. You can buy and sell goods here.")
        makeMarket(room: marketplace, playerLevel: 1)
        let castleCourtyard = Room(tag: "in the castle courtyard")
        let throneRoom = Room(tag: "at the Witch's Throne.")
        let blackForest2 = Room(tag: "in the second area of the black forest.")
        let blackForestN = Room(tag: "in the northern area of the black forest.")
        let castleHall = Room(tag: "in the castle hall")
        let castleKitchen = Room(tag: "in the castle's kitchen")
        let castleDungeon = Room(tag: "in the castle's dungeoon. Be careful! You may want to turn back if you are a low level!")
        let castleDungeonDepths = Room(tag: "in the deepest, darkest part of the dungoen. You can barely see and hear a sound!")
        let castleBackCourtyard = Room(tag: "you've excaped the dungeon. In the castle's back courtyard.")
        let castleStairs = Room(tag: "on the long stairway up to The Witch's Lair. Proceed with caution. Turn back if you're not level 10. Or try your luck ;)")
        let witchesLair = Room(tag: "You have reached the Witch! Time for the final Showdown!!!")
        //let trap = Trap(tag: "in the parking lot of CCT")
        //blackForestE.delegate = trap
        
        var dragon = NPC(castleDungeonDepths, "The Witch's Pet Dragon", 10)
        dragon.inventory.addItem(item: Consumable(50, 4, "Dragon Blood"))
        
        var witch = NPC(witchesLair, "The Witch", 1)
        witchesLair.addNPC(witch)
        var door : Door = connect(firstRoom: swiftville, secondRoom: graveyard, firstLabel: "swiftville", secondLabel: "graveyard")
        
        door = connect(firstRoom: graveyard, secondRoom: blackForestE, firstLabel: "graveyard", secondLabel: "blackforest")
        
        door = connect(firstRoom: blackForestE, secondRoom: blackForest2, firstLabel: "blackforest", secondLabel: "blackforest2")
        
        door = connect(firstRoom: blackForest2, secondRoom: graveyard, firstLabel: "blackforest2", secondLabel: "graveyard")
        
        door = connect(firstRoom: graveyard, secondRoom: blackForest2, firstLabel: "graveyard", secondLabel: "blackforest2")
        
        door = connect(firstRoom: graveyard, secondRoom: marketplace, firstLabel: "graveyard", secondLabel: "marketplace")
        
        door = connect(firstRoom: blackForestE, secondRoom: castleCourtyard, firstLabel: "blackforest", secondLabel: "courtyard")
        
        door = connect(firstRoom: castleCourtyard, secondRoom: castleHall, firstLabel: "courtyard", secondLabel: "castlehall")

        door = connect(firstRoom: castleHall, secondRoom: throneRoom, firstLabel: "castlehall", secondLabel: "throneroom")

        door = connect(firstRoom: castleHall, secondRoom: castleKitchen, firstLabel: "castlehall", secondLabel: "castlekitchen")
        
        door = connect(firstRoom: castleKitchen, secondRoom: castleDungeon, firstLabel: "castleKitchen", secondLabel: "castledungeon")

        door = connect(firstRoom: castleDungeon, secondRoom: castleDungeonDepths, firstLabel: "castledungeon", secondLabel: "castledungeondepths")
        
        door = connect(firstRoom: castleDungeonDepths, secondRoom: castleBackCourtyard, firstLabel: "castledungeondepths", secondLabel: "backcourtyard")
        
        door = connect(firstRoom: castleBackCourtyard, secondRoom: castleHall, firstLabel: "backcourtyard", secondLabel: "castlehall")
        door = connect(firstRoom: castleBackCourtyard, secondRoom: blackForestN, firstLabel: "backcourtyard", secondLabel: "blackforestn")
        door = connect(firstRoom: blackForestN, secondRoom: blackForest2, firstLabel: "blackforestn", secondLabel: "blackforest2")
        door = connect(firstRoom: throneRoom, secondRoom: castleStairs, firstLabel: "throneroom", secondLabel: "castlestairs")
        door = connect(firstRoom: castleStairs, secondRoom: witchesLair, firstLabel: "castlestairs", secondLabel: "witcheslair")
        
        _trigger = throneRoom
        
        return swiftville
    }
    
}
//
//  GameWorld.swift
//  StarterGame
//
//  Created by Jerum on 4/16/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
