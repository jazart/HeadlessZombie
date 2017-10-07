//
//  Consumable.swift
//  StarterGame
//
//  Created by Jerum on 4/11/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class Consumable : Item{
    private var _healthBoost : Double?
    var healthBoost : Double{
        get{
            return _healthBoost!
        }
        set{
            _healthBoost = newValue
        }
    }
    private var _healthDrain : Double?
    var healthDreain : Double{
        get{
            return _healthDrain!
        }
        set{
            _healthDrain = newValue
        }
    }

    
    init(_ hBoost : Double, _ hDrain : Double, _ name : String){
        super.init(name)
        _healthBoost = hBoost
        _healthDrain = hDrain
        value = Int(arc4random_uniform(1) + 10)
    }
    
}
