//
//  Equipment.swift
//  StarterGame
//
//  Created by Jerum on 4/11/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class Equipment : Item{
    private var _defense : Double = 0
    public var defense : Double {
        get{
            return _defense * (1.0 - _condition)
        }
        set(newValue){
            _defense = newValue
        }
    }
    
    private var _attack : Double = 0
    public var attack : Double{
        get{
            return _attack
        }
        set(newValue){
            _attack = newValue
        }
    }
    
    private var _condition : Double = 1.0
    var condition : Double {
        get{
            return _condition
        }
        set{
            _condition = newValue
        }
    }
    init(_ attack: Double, _ defense: Double, _ equipName : String) {
        super.init(equipName)
        self.attack = attack
        self.defense = defense
        self.value = Int(Double(arc4random_uniform(1) + 50))
        self.weight = Int(arc4random_uniform(5) + 20)
        
    }
    
    convenience init(){
        self.init(3,3,"Dagger")
    }
    func getDescription()->String?{
        return self.name
    }
    
}


