//
//  RegularLock.swift
//  StarterGame
//
//  Created by Jerum on 4/11/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class RegularLock : Lockable{
    private var _lock : Bool = false
    private let _key : ThingProtocol = Thing(name :"key")
    private var _insertedKey : ThingProtocol?
    
    var key : ThingProtocol?{
        get{
            let savedKey = _insertedKey
            _insertedKey = nil
            return savedKey!
        }
        set{
            _insertedKey = newValue
        }
    }
    
    init(){
       _insertedKey = _key
    }
    
    func lock(){
        if _insertedKey != nil{
            if _insertedKey! as! Thing === _key as! Thing{
                _lock = true
            }
        }
    }
    
    func unlock(){
        if _insertedKey != nil{
            if _insertedKey! as! Thing === _key as! Thing{
                _lock = false
            }
        }
    }
    
    func isLocked()-> Bool{
        return _lock
    }
    
    func isUnlocked()-> Bool{
        return !_lock
    }
    
    func canOpen()-> Bool{
        if(isUnlocked()){
            return true
        }
        else{
            return false
        }
    }
    
    func canClose()-> Bool{
        return true
    }
    
}
