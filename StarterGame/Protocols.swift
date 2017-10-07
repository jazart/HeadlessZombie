//
//  Protocols.swift
//  StarterGame
//
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//

import Foundation


protocol RoomProtocol {
    func setExit(_ exitName : String, door : Door)
    
    func getExit(_ exitName : String) -> Door?
    
    func getExits() -> String
    
    func description() -> String
    
    func setContainer(_ containerRoom : Room)
    
}

protocol Closeable {
    func open()
    func close()
    func isClosed()->Bool // if  a property it could be closed
    func isOpen()->Bool //if a property it could be open
}

protocol ThingProtocol{
    var name : String{get}
    
}

protocol Lockable{
    var  key : ThingProtocol?{get set}
    func lock()
    func unlock()
    func isLocked()-> Bool
    func isUnlocked()-> Bool
    func canOpen()-> Bool
    func canClose()-> Bool
}
