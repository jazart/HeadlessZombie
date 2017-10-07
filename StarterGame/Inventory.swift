//
// Created by Jerum on 4/10/17.
// Copyright (c) 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class Inventory{
    
    private var _maxCapacity : Int
    var maxCapacity : Int{
        get{
            return _maxCapacity
        }
        set(newValue){
            _maxCapacity = newValue
        }
    }

    private var _currentCapacity : Int
    var currentCapacity : Int{
        get{
            return _currentCapacity
        }
        set(newValue){
            _currentCapacity = newValue
        }
    }
    
    var items : [String : Item]
    
    init(){
        _maxCapacity = 50
        _currentCapacity = 0
        items = [String : Item]()

    }

    func addItem(item : Item){
        item.name = item.name.lowercased()
        items[item.name] = item
        currentCapacity += item.weight
        
        
    }
    
    func removeItem(item : String)-> Item?{
        currentCapacity -= (items[item]?.weight)!
        return (items.removeValue(forKey: item))
    }
    
    func overCapacity()->Bool{
        return currentCapacity > maxCapacity
    }


}
