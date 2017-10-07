//
//  Thing.swift
//  StarterGame
//
//  Created by Jerum on 4/13/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class Thing : ThingProtocol{
    private var _name : String
    var name : String{
        get{
            return _name
        }
        set(newValue){
            _name = newValue
        }
    }
    
    convenience init(){
        self.init(name: "nameless")
        
    }
    
    init(name: String){
        _name = name
    }
    
}
