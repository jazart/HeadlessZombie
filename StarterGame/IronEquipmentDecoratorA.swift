//
//  EquipmentDecoratorA.swift
//  StarterGame
//
//  Created by Jerum on 4/16/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
//decorator pattern
class IronEquipmentDecoratorA : Equipment{
    
    private var item = Equipment()
    init(_ newItem : Equipment){
        super.init(newItem.attack, newItem.defense, newItem.name)
        self.item = newItem
        self.name = "Iron " + self.name
        self.weight += 3
        self.attack += 10
        self.defense += 8

    }
    
    override func getDescription() -> String? {
        return "Iron " + item.name
    }
    
    func getWeight()->Int{
        return self.item.weight + 3 //adds 3 to the base item's weight
    }
    
}
