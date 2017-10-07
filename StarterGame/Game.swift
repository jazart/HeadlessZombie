

import Foundation
import Cocoa

class Game {
    var player : Player?
    var parser : Parser
    var playing : Bool
    var npc : NPC?
    init(gameIO : GameOutput) {
        //        let gameWorld : GameWorld = GameWorld() this is no longer needed since we made a shared instance in GameWorld
        playing = false
        parser = Parser(newCommands: CommandWords())
        player = Player(room: GameWorld.sharedInstance.entrance, output: gameIO)
        let nc = NotificationCenter.default
        nc.addObserver(forName: Notification.Name(rawValue: "PlayerWillEnterRoom"), object: nil, queue: nil, using: playerWillEnterRoom)
        nc.addObserver(forName: Notification.Name(rawValue:"enemyEncounter"), object: nil, queue: nil, using: enemyEncounter)
        nc.addObserver(forName: Notification.Name(rawValue:"playerDied"), object: nil, queue: nil, using: playerDied)
        nc.addObserver(forName: Notification.Name(rawValue:"gainedXp"), object: nil, queue: nil, using: gainedXp)
        nc.addObserver(forName: Notification.Name(rawValue:"newItemsForLevel"), object: nil, queue: nil, using: newItemsForLevel)
        nc.addObserver(forName: Notification.Name(rawValue:"exploredWorld"), object: nil, queue: nil, using: exploredWorld)
        nc.addObserver(forName: Notification.Name(rawValue:"levelUpStory"), object: nil, queue: nil, using: levelUpStory)
        nc.addObserver(forName: Notification.Name(rawValue:"witchDied"), object: nil, queue: nil, using: witchDied)
    }
    
    func witchDied(notification : Notification)->Void{
        if((player?.currentRoom.npc?.name)! == "The Witch" && (player?.currentRoom.npc?.health)! < 1.0){
            self.playerWins()
        }
    }
    func levelUpStory(notification : Notification)->Void{
        if(player?.level == 3){
            player?.outputMessage(level3Story(), color: NSColor.black)
        }
        
        if((player?.level)! == 5){
            player?.outputMessage(level5Story(), color: NSColor.black)
        }
        
        if((player?.level)! == 10){
            player?.outputMessage(level10Story(), color: NSColor.black)
        }
    }
    
    func exploredWorld(notification: Notification)->Void{
        if((player?.moves.count)! == 3 || (player?.moves.count)! == 7){
            GameWorld.sharedInstance.populateWorld(player: player!)
            GameWorld.sharedInstance.generateItems(player: player!)
            player?.outputMessage("\nBe careful, there are now more enemies lurking about and new items to discover!")

        }
        
    }
    
    func level3Story()->String{
        return "Your mind begins racing and you suddenly become dizzy. A vision of your past beings to materialize in your mind. Yes..you were laying on a bed, it was cold and you heard screaming. The screaming got louder but you couldn't make out the voice. Suddenly you faint from the vision and wake up hours later."
    }
    
    func level5Story()->String{
        return "As you feel your humanity returning you scars and skin began to heal. You feel a vibration as you begin to blank out..You recall two voices: 'Ah yes this will be a fine speciman!..But will he survive? The chances are low but it's worth the risk.' You see the woman stab the man she's conversing with and bring the blood to inject into you...The pain reverberates...The vision ends. And the quest continues."
    }
    
    func level10Story()->String{
        return "Through your trials in the forest and graveyard, your body has nearly recovered. Your mind is clear and even though your head is missing you no longer feel tied down by the unexplaineable pressure you once felt. Another vison...'NO...NO what have I done...this was supposed to be the cure but the procedure has gone horribly wrong. I must reverse the effects....wait NO I can still salvage the experiment' At that moment you feel you head severed. Now you are certain the witch used you for her experiments. Go confront her and learn the truth!"
    }
    
    func playerWins(){
        player?.outputMessage("The witch breathes for air as you strike her to the ground. You apprach her and demand for your head. She cackles and looks at you. 'You don't get it do you. You were sick child but I saved you...I saved you..and so did your father. He gave is life. Never forget that.' She raises her arms and before you can react, she blast you with a powerful spell. Your mask shatters an at last your head has been restored. You look at the world and realize..it''s not a fantasy world. It wasnt a witch. You look closely at her and you see now. You've just murdered your mother in cold blood.", color: NSColor.black)
        self.end()
    }
    func newItemsForLevel(notification: Notification)-> Void{
        let playerLevel = (player?.level)!
        
        if(playerLevel == 3 || playerLevel == 5){
            GameWorld.sharedInstance.makeMarket(room: GameWorld.sharedInstance.marketplace, playerLevel: Double(playerLevel))
            player?.outputMessage("\nHey go checkout the marketplace. More powerful items have been added ;).", color: NSColor.purple)

        }
    }
    
    func gainedXp(notification: Notification)-> Void{
        let nc = NotificationCenter.default
        if((player?.level)! < 3) {
            if ((player?.xp)! >= 10){
                nc.post(name: Notification.Name(rawValue:"newItemsForLevel"), object: self)
                player?.levelUp()
                nc.post(name: Notification.Name(rawValue:"newItemsForLevel"), object: self)
            }
        }
        
        if ((player?.level)! < 5 && (player?.level)! > 3){
            if((player?.xp)! > 50){
                player?.levelUp()
            }
        }
        
        if((player?.level)! >= 5) {
            if ((player?.xp)! > 100){
                player?.levelUp()
            }
        }
    }
    
    func playerWillEnterRoom(notification: Notification)-> Void{
        //player?.outputMessage("\n\t Player entered room", color: NSColor.purple)
        let room : Room = notification.object as! Room
        if room === GameWorld.sharedInstance.trigger{
            player?.outputMessage("\n\t You got to the Throne Room but you see no sign of the Witch. As you walk up to the throne you see a note. 'Come find me if you dare young One. I don't know how you survied the experiment but this time you will die for good!' ", color: NSColor.black)
        } //This is a way to see whether you have entered a specific location
        
        //player?.outputMessage("\n\t \(room.tag)", color: NSColor.green)
    }
    
    func enemyEncounter(notification: Notification)-> Void{
        let room : Room = notification.object as! Room
        if room.npc != nil{
            player?.outputMessage("\nEnemy encountered. Prepare for battle!")
            player?.outputMessage("\nYou are now in battle! Attack or Defend!")

        }
    }
    
    func playerDied(notification: Notification)-> Void{
        if (player?.health)! < 1{
            self.end()
        }
    }
    
    func start() {
        playing = true
        player?.outputMessage(welcome())
    }
    
    func end() {
        playing = false
        player?.outputMessage(goodbye())
    }
    
    func welcome() -> String {
        let message = "Welcome back, you're undead!\n\nAn evil witch has stolen your head to use for witchcraft. Find and defeat her to get your head and continue your life. Be careful though. She has minions all about just protecting her land. Find equipment in rooms and shops to help you in your quest. All you have now is the clothes on your back and a weak helmet to diguise the fact that you're headless!\n\nType 'help' if you need help."
        return "\(message)\n\n\(player!.currentRoom.description())"
        
    }
    
    func goodbye() -> String {
        return "\nThank you for playing, Goodbye.\n"
    }
    
    func execute(_ commandString : String) -> Bool {
        var finished : Bool = false
        if playing {
            player?.commandMessage("\n>\(commandString)")
            let command : Command? = parser.parseCommand(commandString)
            if command != nil {
                finished = (command?.execute(player!))!
            } else {
                player?.errorMessage("\nI don't understand...")
            }
        }
        return finished
    }
}


