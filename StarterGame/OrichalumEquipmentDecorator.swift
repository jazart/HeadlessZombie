//
//  OrichalumIEquipmentDecorator.swift
//  StarterGame
//
//  Created by Jerum on 4/18/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class OrichalumEquipmentDecarator : Equipment{
    
    private var item = Equipment()
    init(_ newItem : Equipment){
        super.init(newItem.attack, newItem.defense, newItem.name)
        self.item = newItem
        self.name = "Orichalum " + self.name
        self.weight += 10
        self.value += 50
        self.attack += 21
        self.defense += 25
    }
    
    override func getDescription() -> String {
        return "Orichalum " + item.getDescription()
    }
    
}
