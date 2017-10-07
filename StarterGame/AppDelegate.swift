//
//  AppDelegate.swift
//  StarterGame
//
//  Created by Rodrigo Obando on 3/15/16.
//  Modified by Rodrigo Obando on 3/9/17.
//  Copyright © 2016-2017 Rodrigo Obando. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    @IBOutlet weak var Output: NSScrollView!
    
    @IBOutlet weak var Command: NSTextField!
    var gameIO : GameOutput?
    var game : Game?
    
/*
    override init() {
        super.init()
    }
*/
    
    @IBAction func Command(_ sender: AnyObject) {
        if game!.execute(sender.stringValue) {
            game!.end()
        }
        Command.stringValue = ""
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let tv : NSTextView = Output.documentView as! NSTextView
        tv.isEditable = false
        gameIO = GameOutput(newOutput: Output.documentView as! NSTextView)
        game = Game(gameIO: gameIO!)
        game!.start()
        Command.becomeFirstResponder()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

