//
//  Stack.swift
//  StarterGame
//
//  Created by Jerum on 4/16/17.
//  Copyright © 2017 Rodrigo Obando. All rights reserved.
//
//not used
import Foundation

class Stack<Room>{
    private var stack : [Room]
    private var top = 0

    init(){
        stack = [Room]()
        top = 0
    }
    
    func push(room: Room){
        stack.append(room)
        stack[top] = room
        top += 1
    }
    
    func pop()->Room?{
        if !isEmpty(){
            top -= 1
            return stack.remove(at: stack.count-1)
        }
        return nil
    }
    
    func peek()->Room?{
        if !isEmpty(){
            return stack[stack.count-1]
        }
        return nil
    }
    
    func isEmpty()->Bool{
        return stack.count < 1
    }
    
    func size()-> Int{
        return top
    }
}
