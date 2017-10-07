//
// Created by Jerum on 4/10/17.
// Copyright (c) 2017 Rodrigo Obando. All rights reserved.
//

import Foundation
class Item{
    private var _obtainable : Bool
    var obtainable : Bool{
        get{
            return _obtainable
        }
        set{
            _obtainable = newValue
        }
    }
    private var _weight : Int
    public var weight : Int{
        get {
            return _weight
        }
        set(newValue){
            _weight = newValue
        }
    }
    private var _value : Int
    public var value : Int{
        get{
            return _value
        }
        set(newValue){
            _value = newValue
        }
    }
    private var _name : String
    var name : String {
        get{
            return _name
        }
        set(newValue){
            _name = newValue
        }
    }

    init(_ name : String){
        self._weight = 0
        self._value = 1
        self._name = name
        _obtainable = true
    }
    
    convenience init(){
        self.init("none")
    }
    
    func getDescription()->String{
        return self.name
    }
}
