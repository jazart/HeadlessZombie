//
//  Door.swift
//  StarterGame
//
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation

class Door : Closeable, Lockable{
    private var _roomA : Room
    var roomA : Room{
        get{
            return _roomA
        }
    }
    private var _roomB : Room
    var roomB : Room{
        get{
            return _roomB
        }
    }
    private var _lock : Lockable?
    private var _closed = false
    
    public var key : ThingProtocol?{
        get{
            if _lock != nil{
                let item = _lock!.key
                return item
            }
            else{
                return nil
            }
        }
        set{
            if _lock != nil{
                let tempKey : ThingProtocol? = _lock?.key
                if tempKey == nil{
                    _lock!.key = newValue
                }
                else{
                    _lock!.key = tempKey
                }
            }
        }
    }
    
   // private convenience init(){ //Using the private modifier, no one outside can try to make an empty door
            //Never put self.init here, will be calling itself until you run out of memory
    //}
    public var lockingMechanism : Lockable?{
        get{
            return _lock
        }
        set(newValue){
            _lock = newValue
        }
    }
    init(roomA : Room, roomB : Room){
        _roomA = roomA
        _roomB = roomB
    }
    
    func room(otherRoom : Room) -> Room{
        if otherRoom === _roomA{
            return _roomB
        }
        else{
            return _roomA
        }
    }
    
    func open(){
        if(_lock != nil){
            if(_lock!.canOpen()){
                _closed = false
            }
        }
        else{
            _closed = false
        }
    }
    
    func close(){
        if(_lock != nil){
            if(_lock!.canClose()){
                _closed = true
            }
        }
        else {
            _closed = true
        }
    }
    
    func isClosed()->Bool{
    
        return false
    }// if  a property it could be closed
    
    func isOpen()->Bool{
        
        return true
    }//if a property it could be open
    
    func lock(){
        if(_lock != nil){
            _lock!.lock()
        }
    }
    
    func unlock(){
        if(_lock != nil){
            _lock!.unlock()
        }
    }
    
    func isLocked()-> Bool{
        if _lock != nil{
            return _lock!.isLocked()
        }
        return false
    }
    
    func isUnlocked()-> Bool{
        if(_lock != nil){
            return _lock!.isUnlocked()
        }
        else{
            return true
        }
    }
    
    func canOpen()-> Bool{
        if(_lock != nil){
            return _lock!.canOpen()
        }
        return true
    }
    
    func canClose()-> Bool{
        if(_lock != nil){
            return _lock!.canClose()
        }
        return true
    }
    
}


func connect(firstRoom : Room, secondRoom: Room, firstLabel: String, secondLabel : String) -> Door {
    let door : Door = Door (roomA: firstRoom, roomB: secondRoom)
    firstRoom.setExit(secondLabel, door : door)
    secondRoom.setExit(firstLabel, door : door)
    return door
}
//For GameWorld swift file
// _trigger = parking
//return outside
//createWorld
