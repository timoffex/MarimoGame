//
//  ControlsHandler.swift
//  WinterGame
//
//  Created by Tima Peshin on 1/3/16.
//  Copyright © 2016 timoffex. All rights reserved.
//

import SpriteKit


class ControlsHandler: NSResponder {
    
    var playerNode: Player
    var keysDown: NSMutableDictionary = NSMutableDictionary()
    
    private func isKeyDown(key: NSString) -> Bool {
        let x = keysDown[key]
        
        if let x = x {
            return x as! Bool
        } else {
            return false
        }
    }
    
    
    init(player p: Player) {
        playerNode = p
        
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func keyDown(theEvent: NSEvent) {
        keysDown[theEvent.characters!] = true
        processKeys()
    }
    
    override func keyUp(theEvent: NSEvent) {
        keysDown[theEvent.characters!] = false
        processKeys()
    }


    private func processKeys() {
        let w = isKeyDown("w")
        let a = isKeyDown("a")
        let s = isKeyDown("s")
        let d = isKeyDown("d")
        
        if w { playerNode.actionMoveUp() }
        else if s { playerNode.actionMoveDown() }
        else { playerNode.actionMoveStopVertical() }
        
        if a { playerNode.actionMoveLeft() }
        else if d { playerNode.actionMoveRight() }
        else { playerNode.actionMoveStopHorizontal() }
    }
}